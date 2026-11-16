module flurry_leaderboard::flurry_leaderboard {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use std::vector;

    const MAX_ENTRIES: u64 = 20;

    /// One leaderboard row: who scored, how much, and when.
    public struct ScoreEntry has copy, drop, store {
        player: address,
        score: u64,
        timestamp: u64,
    }

    /// Shared leaderboard object holding the top MAX_ENTRIES scores.
    public struct Leaderboard has key {
        id: UID,
        entries: vector<ScoreEntry>,
    }

    /// Created once at publish time and shared so anyone can submit.
    fun init(ctx: &mut TxContext) {
        let board = Leaderboard {
            id: object::new(ctx),
            entries: vector::empty(),
        };
        transfer::share_object(board);
    }

    /// Submit a score. Inserts it in descending order and trims the
    /// list to the top MAX_ENTRIES. Anyone can call it; the sender's
    /// address is recorded automatically.
    public entry fun submit_score(board: &mut Leaderboard, score: u64, ctx: &mut TxContext) {
        let entry = ScoreEntry {
            player: tx_context::sender(ctx),
            score,
            timestamp: tx_context::epoch_timestamp_ms(ctx),
        };
        let len = vector::length(&board.entries);
        let mut i = 0;
        while (i < len) {
            if (score > vector::borrow(&board.entries, i).score) {
                break;
            };
            i = i + 1;
        };
        vector::insert(&mut board.entries, entry, i);
        while (vector::length(&board.entries) > MAX_ENTRIES) {
            vector::pop_back(&mut board.entries);
        };
    }

    /// Read the whole leaderboard (already sorted, highest first).
    public fun top_scores(board: &Leaderboard): vector<ScoreEntry> {
        board.entries
    }

    public fun entry_count(board: &Leaderboard): u64 {
        vector::length(&board.entries)
    }
}
