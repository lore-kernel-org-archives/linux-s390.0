Return-Path: <linux-kernel-owner+w=401wt.eu-S1755824AbZCKRFl@vger.kernel.org>
From: Frans Pop <elendil@planet.nl>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator
Date: Wed, 11 Mar 2009 18:05:24 +0100
References: <200903080230.10099.elendil@planet.nl> <1236733226.6080.28.camel@localhost> <200903111703.41663.elendil@planet.nl>
In-Reply-To: <200903111703.41663.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903111805.26832.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wednesday 11 March 2009, Frans Pop wrote:
> From this I conclude that clock->error is getting buggered somewhere
> else: we get a completely different value back from what is calculated
> here.

Some extra printks at least close the loop:

0: scale/shift: 32/8, xtime_ns old: 168555264000, new: 168555264256
     tv_ns: 658419001, rem: -256, old_err: 0, error: -4294867296
bigadjust: adj: 2097152, int: 260046848, offs: 4194304
CS adjust: -4294867296 -> -4292487689804800

1: scale/shift: 32/8, xtime_ns old: 168551069952, new: 168551070208
     tv_ns: 658402618, rem: -256, old_err: -4292487689804800, error: -4292501984672096
bigadjust: adj: 4194304, int: 520093696, offs: 12582912
CS adjust: -4292501984672096 -> -12807120030269440

2: scale/shift: 32/8, xtime_ns old: 168538487296, new: 168538487552
    tv_ns: 658353467, rem: -256, old_err: -12807120030269440, error: -12807124325236736
bigadjust: adj: 1048576, int: 130023424, offs: 4194304
CS adjust: -12807124325236736 -> -14918186650466656

"bigadjust" is from just before the return in clocksource_bigadjust.
"CS adjust" is from after clock->error gets calculated in clocksource_adjust.
