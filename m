Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726046AbgGTO6Z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jul 2020 10:58:25 -0400
Message-ID: <1595257015.5055.8.camel@linux.ibm.com>
Subject: Re: [PATCH v6] ima: move APPRAISE_BOOTPARAM dependency on
 ARCH_POLICY to runtime
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 20 Jul 2020 10:56:55 -0400
In-Reply-To: <d337cbba-e996-e898-1e75-9f142d480e5e@linux.vnet.ibm.com>
References: <20200713164830.101165-1-bmeneg@redhat.com>
         <d337cbba-e996-e898-1e75-9f142d480e5e@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Nayna <nayna@linux.vnet.ibm.com>, Bruno Meneguele <bmeneg@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org
Cc: erichte@linux.ibm.com, nayna@linux.ibm.com, stable@vger.kernel.org

On Mon, 2020-07-20 at 10:40 -0400, Nayna wrote:
> On 7/13/20 12:48 PM, Bruno Meneguele wrote:
> > The IMA_APPRAISE_BOOTPARAM config allows enabling different "ima_appraise="
> > modes - log, fix, enforce - at run time, but not when IMA architecture
> > specific policies are enabled.  This prevents properly labeling the
> > filesystem on systems where secure boot is supported, but not enabled on the
> > platform.  Only when secure boot is actually enabled should these IMA
> > appraise modes be disabled.
> >
> > This patch removes the compile time dependency and makes it a runtime
> > decision, based on the secure boot state of that platform.
> >
> > Test results as follows:
> >
> > -> x86-64 with secure boot enabled
> >
> > [    0.015637] Kernel command line: <...> ima_policy=appraise_tcb ima_appraise=fix
> > [    0.015668] ima: Secure boot enabled: ignoring ima_appraise=fix boot parameter option
> >

Is it common to have two colons in the same line?  Is the colon being
used as a delimiter when parsing the kernel logs?  Should the second
colon be replaced with a hyphen?  (No need to repost.  I'll fix it
up.)
 

> > -> powerpc with secure boot disabled
> >
> > [    0.000000] Kernel command line: <...> ima_policy=appraise_tcb ima_appraise=fix
> > [    0.000000] Secure boot mode disabled
> >
> > -> Running the system without secure boot and with both options set:
> >
> > CONFIG_IMA_APPRAISE_BOOTPARAM=y
> > CONFIG_IMA_ARCH_POLICY=y
> >
> > Audit prompts "missing-hash" but still allow execution and, consequently,
> > filesystem labeling:
> >
> > type=INTEGRITY_DATA msg=audit(07/09/2020 12:30:27.778:1691) : pid=4976
> > uid=root auid=root ses=2
> > subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=appraise_data
> > cause=missing-hash comm=bash name=/usr/bin/evmctl dev="dm-0" ino=493150
> > res=no
> >
> > Cc: stable@vger.kernel.org
> > Fixes: d958083a8f64 ("x86/ima: define arch_get_ima_policy() for x86")
> > Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
> 
> 
> Reviewed-by: Nayna Jain<nayna@linux.ibm.com>
> Tested-by: Nayna Jain<nayna@linux.ibm.com>

Thanks, Nayna.

Mimi
