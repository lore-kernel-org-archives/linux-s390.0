Return-Path: <linux-kernel-owner+w=401wt.eu-S1752022AbYK0Kch@vger.kernel.org>
Message-Id: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:20 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/60] s390 feature patches for 2.6.29
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Greetings,
the features branch of git390 has grown to 60 patches for the next
merge window:

Carsten Otte (1):
      [S390] tape message cleanup

Christian Borntraeger (3):
      [S390] vmcp: remove BKL
      [S390] convert vmcp printks to pr_xxx macros.
      [S390] convert cpcmd printks to pr_xxx macros.

Christian Maaser (1):
      [S390] ap: Minor code beautification.

Christof Schmitt (2):
      [S390] zfcp: Report microcode level through service level interface
      [S390] convert zfcp printks to pr_xxx macros.

Cornelia Huck (1):
      [S390] dasd: Use accessors instead of using driver_data directly.

Felix Beck (1):
      [S390] zcrypt: Use of Thin Interrupts

Frank Blaschka (1):
      [S390] convert qeth printks to dev_xxx and pr_xxx macros.

Frank Munzert (1):
      [S390] convert vmur printks to pr_xxx macros.

Gerald Schaefer (2):
      [S390] convert appldata printks to pr_xxx macros.
      [S390] convert monreader printks to pr_xxx macros.

Heiko Carstens (8):
      [S390] convert etr/stp to stop_machine interface
      [S390] convert s390 to generic IPI infrastructure
      [S390] Move stfle to header file.
      [S390] ftrace: function tracer backend for s390
      [S390] cio: get rid of compile warning
      [S390] mark disabled_wait as noreturn function
      [S390] sclp vt220: fix compile warning
      [S390] Remove initial kernel stack backchain initialization.

Hendrik Brueckner (3):
      [S390] iucv: Locking free version of iucv_message_(receive|send)
      [S390] s390/hvc_console: z/VM IUCV hypervisor console support
      [S390] provide documentation for hvc_iucv printk & kernel parameter.

Hongjie Yang (1):
      [S390] convert dcssblk and extmem printks messages to pr_xxx macros.

Jan Glauber (7):
      [S390] qdio: fix qeth port count detection
      [S390] qdio: add eqbs/sqbs instruction counters
      [S390] qdio: fix compile warning under 31 bit
      [S390] qdio: rework debug feature logging
      [S390] qdio: improve error handling for unexpected buffer states
      [S390] qdio: improve inbound buffer acknowledgement
      [S390] convert cpacf printks to pr_xxx macros.

Kay Sievers (1):
      [S390] struct device - replace bus_id with dev_name(), dev_set_name()

Klaus-D. Wacker (1):
      [S390] convert lcs printks to dev_xxx and pr_xxx macros.

Martin Schwidefsky (16):
      [S390] arch_setup_additional_pages arguments
      [S390] introduce vdso on s390
      [S390] serialize stp/etr work
      [S390] service level interface.
      [S390] __page_to_pfn warnings
      [S390] remove ptrace warning on 31 bit.
      [S390] remove warnings with functions ending in BUG
      [S390] Add processor type march=z10 and a processor type safety check.
      [S390] add new machine types to setup_hwcaps.
      [S390] convert xpram printks to pr_xxx macros.
      [S390] convert time printks to pr_xxx macros.
      [S390] convert setup printks to pr_xxx macros.
      [S390] convert ap_bus printks to pr_xxx macros.
      [S390] convert sclp printks to pr_xxx macros.
      [S390] convert cpu related printks to pr_xxx macros.
      [S390] convert vmlogrdr printks to pr_xxx macros.

Melissa Howland (1):
      [S390] convert monwriter printks to pr_xxx macros.

Michael Ernst (1):
      [S390] convert cio printks to pr_xxx macros.

Michael Holzheu (3):
      [S390] convert hypfs printks to pr_xxx macros.
      [S390] convert s390 debug feature printks to pr_xxx macros.
      [S390] convert zfcp dumper printks to pr_xxx macros.

Peter Oberparleiter (1):
      [S390] cio: update sac values

Peter Tiedemann (1):
      [S390] convert ctcm printks to dev_xxx and pr_xxx macros.

Sebastian Ott (1):
      [S390] cio: move irritating comment.

Stefan Haberland (1):
      [S390] dasd: improve dasd statistics proc interface

Ursula Braun (1):
      [S390] convert iucv printks to dev_xxx and pr_xxx macros.

About half of it is the pr_xyz kernel message rework. The other half
contains a few new features, the most interesting one is the vdso
support for gettimeofday and clock_gettime. Notable as well:
 - the conversion to the generic IPI infrastructure
 - the thin interrupt support for the crypto cards
 - the support for console over iucv
 - the backend for the function tracer.

Review is as always very welcome.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
