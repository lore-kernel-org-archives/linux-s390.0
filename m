Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F8322126C;
	Fri, 28 Aug 2026 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787924637; cv=none; b=cbd7ZzdebsunhSLQrsQrTd2Unbr3O1b5ZwWF68KTk1hcCZ6O20VedO8v+dXz0J68oIfSb3GOgLXOVM5Bnhuw/tOxJKpW5+/CDCHaH4jfzAh4e+wmoFpUx7a8/1g8vNMeT1ePJ7pt/aEStpegMPF8SUuPcp9akCupKOOptdqWXDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787924637; c=relaxed/simple;
	bh=1dIhrn+F1Hnwk3KJKk1xquIRGBPMga+8piYvR7NhKVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kg9J8dFRvtmM3+Ib8A0L+5VvjdjuFWXU8MVQ1A84je/kuODrCqa+f/gnfHk1TJvN2CvANsI+9MSbDIWgw8dikRWRD/OcB6PqYhqS7SXIjPPFSaQknjp3WDhte/ZFyji8BgUSXjZdl3UCLA0xyMyhFYSAM4Reui86BnUYoCTR62Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YF9amFJP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YF9amFJP"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDVaEl2186065;
	Fri, 28 Aug 2026 13:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=VYLsTDHvqMB81EJS1COSNG/7yyEet1
	R+ZVbbyJxJ/mw=; b=YF9amFJPD7X6Z4jNAPV54HYHqxVoWtJYUJ2UgojAPXwxxK
	OfK6DQGnmlNrjTAuWekQdBn0+eVwj7QN06qWBMfBmVggTH+GBhrF4pLtMFUsWuQc
	vn5SKJMYfktFbWQIQ+nMSHELUbbh2zxFdFr5M57f4o9wF38lbOlVyKUkGkc5yFZk
	8k0qQDTEL3yJXpj0dIvZ08Zsxr/qJ3ZCS8K6IHTetdt4xeLdsP5MhwznhU+Jju9s
	pg9Fq+/lmJKfh21mvAs1X7yT6jLUNYNr3J4DfYBmK7qCEY2rZnzbY7DrTWvVLpcm
	W7ABxeEk05KDIhwIyCgoLK6yzW/UKl5Wmo8wPQeQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxv2t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 13:43:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SDfFqi017206;
	Fri, 28 Aug 2026 13:43:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3kecsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 13:43:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SDhfkC34472290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 13:43:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 909412004B;
	Fri, 28 Aug 2026 13:43:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70ED120043;
	Fri, 28 Aug 2026 13:43:41 +0000 (GMT)
Received: from tuxmaker (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 28 Aug 2026 13:43:41 +0000 (GMT)
Date: Fri, 28 Aug 2026 15:43:40 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] tracing: Delay module ref count for "enable_event"
 trigger
Message-ID: <20260828134340.2501683A24-agordeev@linux.ibm.com>
References: <20260724132415.1b5005db@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724132415.1b5005db@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExNyBTYWx0ZWRfXzG0V74Cash63
 oDh/NsUH0coIlbPMk/ZoPGZ43ejt38nfOHaz/N5XMUIJbv+ExU1Sv6ihk+B7GuaL0oU+w5SoCVW
 TfewNk5lvTCagmdI5H5V7picd5xCsPk=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a919090 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=c92rfblmAAAA:8
 a=pGLkceISAAAA:8 a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8 a=zzVfXM5F_YHknsDCf1IA:9
 a=CjuIK1q_8ugA:10 a=GvGzcOZaWPEFPQC_NcjD:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: 8eyF4bKoU0GKgBBRS6T1Ap8aFCG9404k
X-Proofpoint-GUID: 8eyF4bKoU0GKgBBRS6T1Ap8aFCG9404k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExNyBTYWx0ZWRfX8hOVwS1YBsQV
 lKgAyY+FUFfDgPQIh7UNh25GzmJBIwvOE4GbokvMWh1kol7TV6+za9mkOkJn2ERrhzlDsBs7xZ0
 8HBVFBJ22BoUE4JdPcQ8r31N7QqSbO8qcai2qLMAxZzlZ8NmpXAXRe4v35ABDC0X/jaTdmxxjN4
 KZ/AqG8zBPXTwyQj2BCailq5hTVAbernzgHuv0AJGyD/mxDDB263P/HJFDyuxfxi2Wuqfc45A/5
 +lWtBXrcA9K4vhMxLCOCkgyClyw0BuPshPcXtJD65MPQPxQiC94hxkZ2ehNwotipRvB4dIu6kC1
 Si4mSpO4UHNZdgVyF5uUEa3VXylZjk6/Z/7QWZry6i3b0bav49Az63TxWxfwkm+HRgzIEJevke7
 nE7sZBkzZME707HNGlGY7GttW3sJ3FFtPI0FMn780p/34NwE6LAXHir+qY0u61OcbEuYRdrC1dR
 DVRmgHvWGpF+9mDcgXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280117

On Fri, Jul 24, 2026 at 01:24:15PM -0400, Steven Rostedt wrote:

Hi Steven!

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Triggers are now delayed from freeing, but can still be triggered until
> after the RCU grace period has ended. The freeing of the enable_event data
> is put into the private_data_free() callback, but the put of the module
> refcount is done immediately.
> 
> It is possible that if a module is removed that has an event that would
> enable (or disable) it is still active, it can read the data of the module
> after it is removed causing a use-after-free bug.
> 
> Move the trace_event_put_ref() that releases the module into the delayed
> callback so that the module can not be removed until any reference to its
> events are finished.
> 
> Cc: stable@vger.kernel.org
> Reported-by: sashiko-bot@kernel.org
> Link: https://sashiko.dev/#/patchset/20260724030523.19081-1-devnexen%40gmail.com
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_trigger.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index 46e60b70a4bb..ad83419cb420 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -1726,7 +1726,10 @@ int event_enable_trigger_print(struct seq_file *m,
>  
>  static void enable_trigger_private_data_free(struct event_trigger_data *data)
>  {
> -	kfree(data->private_data);
> +	struct enable_trigger_data *enable_data = data->private_data;
> +
> +	trace_event_put_ref(enable_data->file->event_call);
> +	kfree(enable_data);
>  }
>  
>  void event_enable_trigger_free(struct event_trigger_data *data)
> @@ -1741,7 +1744,6 @@ void event_enable_trigger_free(struct event_trigger_data *data)
>  		/* Remove the SOFT_MODE flag */
>  		trace_event_enable_disable(enable_data->file, 0, 1);
>  		data->private_data_free = enable_trigger_private_data_free;
> -		trace_event_put_ref(enable_data->file->event_call);
>  		trigger_data_free(data);
>  	}
>  }

This patch increasingly looks as a regression on s390.
We are hitting this once in a while when running the ftrace selftests:

    [ 1201.491469] ftrace: citest-start trigger-eventonoff.tc
    [ 1203.807215] Unable to handle kernel pointer dereference in virtual kernel address space
    [ 1203.807239] Failing address: 6b6b6b6b6b6b6000 TEID: 6b6b6b6b6b6b6803 ESOP-2 FSI
    [ 1203.807249] Fault in home space mode while using kernel ASCE.
    [ 1203.807259] AS:0000000031a20007 R3:0000000000000024 
    [ 1203.807292] Oops: 0038 ilc:2 [#1]SMP 
    [ 1203.807299] Modules linked in: algif_hash af_alg nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables dm_service_time zfcp scsi_transport_fc vfio_ccw s390_trng mdev vfio_iommu_type1 vfio sch_fq_codel drm i2c_core drm_panel_orientation_quirks dm_multipath vsock_loopback vmw_vsock_virtio_transport_common vsock diag288_wdt watchdog prng aes_s390 pkey_ep11 pkey_cca zcrypt paes_s390 phmac_s390 rng_core pkey_pckmo scsi_dh_alua scsi_dh_rdac scsi_dh_emc pkey crypto_engine autofs4 ecdsa_generic ecc sha512 [last unloaded: trace_printk]
    [ 1203.807361] CPU: 5 UID: 0 PID: 55241 Comm: trigger_data_fr Not tainted 7.2.0-20260731.rc5.300.fc44.s390x+debug #1 PREEMPT 
    [ 1203.807371] Hardware name: IBM 8561 T01 701 (z/VM 7.4.0)
    [ 1203.807373] Krnl PSW : 0704e00180000000 0000033302ba172a (trigger_kthread_fn+0x10a/0x160)
    [ 1203.807396]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
    [ 1203.807405] Krnl GPRS: 0000000000000000 0000033302ba1520 6b6b6b6b6b6b6b6b 0000022a16ae6b48
    [ 1203.807410]            0000000000000240 0000000000000240 0000022889f18100 0000000000000000
    [ 1203.807413]            0000022889f18100 000002297a5a3810 ffffffffffffff98 00000229b3f60080
    [ 1203.807416]            0000022889f18100 0000000000000000 0000000000000000 000002b304693d98
    [ 1203.807425] Krnl Code: 0000033302ba1718: e390b0280004	lg	%r9,40(%r11)
                              0000033302ba171e: e33090000004	lg	%r3,0(%r9)
                             *0000033302ba1724: e32030100004	lg	%r2,16(%r3)
                             >0000033302ba172a: 9110205b		tm	91(%r2),16
                              0000033302ba172e: a774ffd2		brc	7,0000033302ba16d2
                              0000033302ba1732: e32020480004	lg	%r2,72(%r2)
                              0000033302ba1738: c0e5fff8c234	brasl	%r14,0000033302ab9ba0
                              0000033302ba173e: a7f4ffcd		brc	15,0000033302ba16d8
    [ 1203.807446] Call Trace:
    [ 1203.807448]  [<0000033302ba172a>] trigger_kthread_fn+0x10a/0x160 
    [ 1203.807456] ([<0000033302ba16c8>] trigger_kthread_fn+0xa8/0x160)
    [ 1203.807464]  [<00000333029f1494>] kthread+0x164/0x190 
    [ 1203.807471]  [<000003330295c7bc>] __ret_from_fork+0x4c/0x340 
    [ 1203.807477]  [<0000033303af492a>] ret_from_fork+0xa/0x30 
    [ 1203.807482] INFO: lockdep is turned off.
    [ 1203.807484] Last Breaking-Event-Address:
    [ 1203.807486]  [<0000033302ba16c8>] trigger_kthread_fn+0xa8/0x160

I did not manage to come up with a reproducer - if you have any idea,
please let me know.

Thanks!
