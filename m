Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbfH0PXH (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 27 Aug 2019 11:23:07 -0400
Subject: Re: [kvm-unit-tests PATCH 1/3] s390x: Move pfmf to lib and make
 address void
References: <20190827134936.1705-1-frankja@linux.ibm.com>
 <20190827134936.1705-2-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e722fde9-d00a-ca65-91a3-9c7801c2352a@redhat.com>
Date: Tue, 27 Aug 2019 17:23:03 +0200
MIME-Version: 1.0
In-Reply-To: <20190827134936.1705-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 27/08/2019 15.49, Janosch Frank wrote:
> It's needed by other tests soon.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/mem.h | 31 ++++++++++++++++++++++
>  s390x/pfmf.c        | 63 ++++++++++++++-------------------------------
>  2 files changed, 50 insertions(+), 44 deletions(-)
[...]
> @@ -80,15 +49,18 @@ static void test_1m_key(void)
>  {
>  	int i;
>  	bool rp = true;
> -	union r1 r1;
> +	union pfmf_r1 r1;
>  	union skey skey;
> +	void *addr = pagebuf;
>  
>  	report_prefix_push("1M");
>  	r1.val = 0;
>  	r1.reg.sk = 1;
> -	r1.reg.fsc = FSC_1M;
> +	r1.reg.fsc = PFMF_FSC_1M;
>  	r1.reg.key = 0x30;
> -	pfmf(r1.val, (unsigned long) pagebuf);
> +	while (addr != pagebuf + 256 * PAGE_SIZE) {
> +	       addr = pfmf(r1.val, addr);
> +	}

Why this change? If PFMF gets interrupted, the PSW should still point to
the PFMF instruction, so no need to loop here ... or do I miss something?

(See PoP, chapter "Execution of Interruptible Instructions")

>  	for (i = 0; i < 256; i++) {
>  		skey.val = get_storage_key((unsigned long) pagebuf + i * PAGE_SIZE);
>  		skey.val &= SKEY_ACC | SKEY_FP;
> @@ -103,15 +75,15 @@ static void test_1m_key(void)
>  
>  static void test_4k_clear(void)
>  {
> -	union r1 r1;
> +	union pfmf_r1 r1;
>  
>  	r1.val = 0;
>  	r1.reg.cf = 1;
> -	r1.reg.fsc = FSC_4K;
> +	r1.reg.fsc = PFMF_FSC_4K;
>  
>  	report_prefix_push("4K");
>  	memset(pagebuf, 42, PAGE_SIZE);
> -	pfmf(r1.val, (unsigned long) pagebuf);
> +	pfmf(r1.val, pagebuf);
>  	report("clear memory", !memcmp(pagebuf, pagebuf + PAGE_SIZE, PAGE_SIZE));
>  	report_prefix_pop();
>  }
> @@ -119,16 +91,19 @@ static void test_4k_clear(void)
>  static void test_1m_clear(void)
>  {
>  	int i;
> -	union r1 r1;
> +	union pfmf_r1 r1;
>  	unsigned long sum = 0;
> +	void *addr = pagebuf;
>  
>  	r1.val = 0;
>  	r1.reg.cf = 1;
> -	r1.reg.fsc = FSC_1M;
> +	r1.reg.fsc = PFMF_FSC_1M;
>  
>  	report_prefix_push("1M");
>  	memset(pagebuf, 42, PAGE_SIZE * 256);
> -	pfmf(r1.val, (unsigned long) pagebuf);
> +	while (addr != pagebuf + 256 * PAGE_SIZE) {
> +	       addr = pfmf(r1.val, addr);
> +	}

dito.

 Thomas
