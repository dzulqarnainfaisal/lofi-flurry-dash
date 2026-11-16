# Lofi Flurry Dash

A 2D endless runner starring **Lofi the Yeti**, built for the **CLAY Hackathon III** by Lofi The Yeti. Lofi dashes down a snowy mountain, jumping rocks and ice spikes, sliding under hanging ice, and grabbing snowflakes and $LOFI coins across three zones: Snowy Slope, Ice Cavern, and Avalanche Peak.

Play it live: **https://dzulqarnainfaisal.github.io/lofi-flurry-dash/** (GitHub Pages, after the first deploy)

## How to play

- **Jump:** Space / ArrowUp / W, or the Jump button (tap on mobile)
- **Slide:** ArrowDown / S, or the Slide button
- **Pause:** P or the Pause button
- **Fullscreen:** the Fullscreen button (landscape on phones; the game rotates itself if the browser blocks rotation)

### Mechanics

- **Stamina (99.9):** drains while running, snowflakes restore it. At 0 stamina Lofi slows down and jumps lower until it recovers.
- **Speed:** starts slow and ramps up as you run further. Blue ice crystals give a 3-second Speed Burst (double speed, double distance points).
- **Intelligence:** golden snowflakes are the rare bonus (+250). Collect 5 in one run to unlock the Genius Yeti bonus (+500).
- **Lives:** 3 hearts. Every hit costs 1 life, with 1.5 seconds of invincibility after a hit.

### Zones

1. **Snowy Slope (0-500 m):** gentle start, rocks and ice spikes only.
2. **Ice Cavern (500-1,500 m):** faster, low hanging ice and rolling snowballs join in.
3. **Avalanche Peak (1,500 m+):** fastest, everything at once, stormy skies.

### Leaderboard

- **Local leaderboard:** your Top 10 runs are saved on your device, no wallet needed.
- **On-chain leaderboard (Sui):** after a run, connect a Sui wallet and submit your score to the on-chain leaderboard. Playing is free and never requires a wallet; the wallet is only for submitting a score on-chain.

## Sui / Move

The on-chain leaderboard lives in `move/flurry_leaderboard/`:

- Module `flurry_leaderboard::flurry_leaderboard`
- Shared object `Leaderboard` holding the top 20 scores (player address, score, timestamp)
- `submit_score(score)` inserts your score in descending order and trims to 20
- `top_scores()` reads the board

### Deploy (testnet)

```bash
cd move/flurry_leaderboard
sui move build
sui client publish --gas-budget 100000000
```

Record the **Package ID** and the **Leaderboard object ID** from the publish output, then set them in `SUI_CONFIG` at the top of the game script in `index.html`. Get free testnet SUI from the Sui testnet faucet.

- **Package ID:** _TBD after first deploy_
- **Leaderboard object ID:** _TBD after first deploy_
- **Network:** Sui testnet

## Run locally

Just open `index.html` in a browser. No build step, no server needed. The game is a single self-contained HTML file (Canvas 2D, vanilla JS, WebAudio chiptune music).

## Hackathon

CLAY Hackathon III (Code Like A Yeti) by Lofi The Yeti / Lofi Foundation. Prize pool $2,450 (1st $1,500 / 2nd $700 / 3rd $250). Track: mini-game featuring Lofi. Built on Sui Network with Move.

## Credits

- Character: Lofi the Yeti, by the Lofi community (drawn in code for this game, in the spirit of the official art).
- Built with Cline (GPT-6) and Magpie.
