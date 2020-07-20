Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37768 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgGTOko (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jul 2020 10:40:44 -0400
Subject: Re: [PATCH v6] ima: move APPRAISE_BOOTPARAM dependency on ARCH_POLICY
 to runtime
References: <20200713164830.101165-1-bmeneg@redhat.com>
From: Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <d337cbba-e996-e898-1e75-9f142d480e5e@linux.vnet.ibm.com>
Date: Mon, 20 Jul 2020 10:40:29 -0400
MIME-Version: 1.0
In-Reply-To: <20200713164830.101165-1-bmeneg@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Bruno Meneguele <bmeneg@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Cc: erichte@linux.ibm.com, nayna@linux.ibm.com, stable@vger.kernel.org


On 7/13/20 12:48 PM, Bruno Meneguele wrote:
> The IMA_APPRAISE_BOOTPARAM config allows enabling different "ima_appraise="
> modes - log, fix, enforce - at run time, but not when IMA architecture
> specific policies are enabled.  This prevents properly labeling the
> filesystem on systems where secure boot is supported, but not enabled on the
> platform.  Only when secure boot is actually enabled should these IMA
> appraise modes be disabled.
>
> This patch removes the compile time dependency and makes it a runtime
> decision, based on the secure boot state of that platform.
>
> Test results as follows:
>
> -> x86-64 with secure boot enabled
>
> [    0.015637] Kernel command line: <...> ima_policy=appraise_tcb ima_appraise=fix
> [    0.015668] ima: Secure boot enabled: ignoring ima_appraise=fix boot parameter option
>
> -> powerpc with secure boot disabled
>
> [    0.000000] Kernel command line: <...> ima_policy=appraise_tcb ima_appraise=fix
> [    0.000000] Secure boot mode disabled
>
> -> Running the system without secure boot and with both options set:
>
> CONFIG_IMA_APPRAISE_BOOTPARAM=y
> CONFIG_IMA_ARCH_POLICY=y
>
> Audit prompts "missing-hash" but still allow execution and, consequently,
> filesystem labeling:
>
> type=INTEGRITY_DATA msg=audit(07/09/2020 12:30:27.778:1691) : pid=4976
> uid=root auid=root ses=2
> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=appraise_data
> cause=missing-hash comm=bash name=/usr/bin/evmctl dev="dm-0" ino=493150
> res=no
>
> Cc: stable@vger.kernel.org
> Fixes: d958083a8f64 ("x86/ima: define arch_get_ima_policy() for x86")
> Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>


Reviewed-by: Nayna Jain<nayna@linux.ibm.com>

Tested-by: Nayna Jain<nayna@linux.ibm.com>


Thanks & Regards,

         - Nayna
