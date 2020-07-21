Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728379AbgGUR03 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Jul 2020 13:26:29 -0400
Message-ID: <1595352376.5311.8.camel@linux.ibm.com>
Subject: Re: [PATCH v6] ima: move APPRAISE_BOOTPARAM dependency on
 ARCH_POLICY to runtime
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 21 Jul 2020 13:26:16 -0400
In-Reply-To: <20200720153841.GG10323@glitch>
References: <20200713164830.101165-1-bmeneg@redhat.com>
         <d337cbba-e996-e898-1e75-9f142d480e5e@linux.vnet.ibm.com>
         <1595257015.5055.8.camel@linux.ibm.com> <20200720153841.GG10323@glitch>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Bruno Meneguele <bmeneg@redhat.com>
Cc: Nayna <nayna@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org, erichte@linux.ibm.com, nayna@linux.ibm.com, stable@vger.kernel.org

On Mon, 2020-07-20 at 12:38 -0300, Bruno Meneguele wrote:
> On Mon, Jul 20, 2020 at 10:56:55AM -0400, Mimi Zohar wrote:
> > On Mon, 2020-07-20 at 10:40 -0400, Nayna wrote:
> > > On 7/13/20 12:48 PM, Bruno Meneguele wrote:
> > > > The IMA_APPRAISE_BOOTPARAM config allows enabling different "ima_appraise="
> > > > modes - log, fix, enforce - at run time, but not when IMA architecture
> > > > specific policies are enabled.  This prevents properly labeling the
> > > > filesystem on systems where secure boot is supported, but not enabled on the
> > > > platform.  Only when secure boot is actually enabled should these IMA
> > > > appraise modes be disabled.
> > > >
> > > > This patch removes the compile time dependency and makes it a runtime
> > > > decision, based on the secure boot state of that platform.
> > > >
> > > > Test results as follows:
> > > >
> > > > -> x86-64 with secure boot enabled
> > > >
> > > > [    0.015637] Kernel command line: <...> ima_policy=appraise_tcb ima_appraise=fix
> > > > [    0.015668] ima: Secure boot enabled: ignoring ima_appraise=fix boot parameter option
> > > >
> > 
> > Is it common to have two colons in the same line?  Is the colon being
> > used as a delimiter when parsing the kernel logs?  Should the second
> > colon be replaced with a hyphen?  (No need to repost.  I'll fix it
> > up.)
> >  
> 
> AFAICS it has been used without any limitations, e.g:
> 
> PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
> microcode: CPU0: patch_level=0x08701013
> Lockdown: modprobe: unsigned module loading is restricted; see man kernel_lockdown.7
> ...
> 
> I'd say we're fine using it.

Ok.  FYI, it's now in next-integrity.

Mimi
