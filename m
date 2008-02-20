Return-Path: <linux-kernel-owner+w=401wt.eu-S1761946AbYBTJqJ@vger.kernel.org>
Date: Wed, 20 Feb 2008 10:45:52 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 07/13] Initialize per cpu lowcores on cpu hotplug.
Message-ID: <20080220094552.GA12635@osiris.boeblingen.de.ibm.com>
References: <20080219144047.587547541@de.ibm.com> <20080219144504.392301782@de.ibm.com> <20080219151355.GA24547@wavehammer.waldi.eu.org> <20080219153855.GA11599@osiris.boeblingen.de.ibm.com> <20080219154149.GB11599@osiris.boeblingen.de.ibm.com> <0d276daad249ac20ae922f4aa9a6e88b@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d276daad249ac20ae922f4aa9a6e88b@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Bastian Blank <bastian@waldi.eu.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

>>>> Boah, workaround alert. Why do you not fix the compiler?
>>>
>>> We need to copy from address 0 (that's where the lowcore resides). But 
>>> gcc
>>> insists to complain if memcpy is used with src == NULL.. Now what?
>>
>> Erm sorry, misread your question. Usually it's a bug to use memcpy with
>> src == NULL. In this case it's ok. So I think it's perfectly ok if gcc
>> emits a warning.
>> If you know of a better way to get around this please let me know.
>
> -ffreestanding or -Wno-nonnull?

Ok, how about the patch below? Everybody happy with it?

---
 arch/s390/kernel/Makefile |    5 +++++
 arch/s390/kernel/smp.c    |    8 +-------
 2 files changed, 6 insertions(+), 7 deletions(-)

Index: linux-2.5/arch/s390/kernel/Makefile
===================================================================
--- linux-2.5.orig/arch/s390/kernel/Makefile
+++ linux-2.5/arch/s390/kernel/Makefile
@@ -4,6 +4,11 @@
 
 EXTRA_AFLAGS	:= -traditional
 
+#
+# Passing null pointers is ok for smp code, since we access the lowcore here.
+#
+CFLAGS_smp.o	:= -Wno-nonnull
+
 obj-y	:=  bitmap.o traps.o time.o process.o base.o early.o \
             setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
 	    semaphore.o s390_ext.o debug.o irq.o ipl.o dis.o diag.o
Index: linux-2.5/arch/s390/kernel/smp.c
===================================================================
--- linux-2.5.orig/arch/s390/kernel/smp.c
+++ linux-2.5/arch/s390/kernel/smp.c
@@ -631,13 +631,7 @@ static int __cpuinit smp_alloc_lowcore(i
 	panic_stack = __get_free_page(GFP_KERNEL);
 	if (!panic_stack || !async_stack)
 		goto out;
-	/*
-	 * Only need to copy the first 512 bytes from address 0. But since
-	 * the compiler emits a warning if src == NULL for memcpy use copy_page
-	 * instead. Copies more than needed but this code is not performance
-	 * critical.
-	 */
-	copy_page(lowcore, &S390_lowcore);
+	memcpy(lowcore, &S390_lowcore, 512);
 	memset((void *)lowcore + 512, 0, sizeof(*lowcore) - 512);
 	lowcore->async_stack = async_stack + ASYNC_SIZE;
 	lowcore->panic_stack = panic_stack + PAGE_SIZE;
