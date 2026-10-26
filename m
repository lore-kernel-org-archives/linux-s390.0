Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792994472;
	b=2xCTM/1CDNOuDU30TPNLpzPIBwn2Ui1JSl4ajiqwfCE9oVYZ2noR1ZdzAQ8G2MFYCllb
	 vAjR972KBmuMOaEJ+FtI5GjGpVRoGl7Tflaaa6I130aHVMEnEaYcTNPh0RRor2/Q6k6x7
	 iV6Te6pItYqoAwCw/euJhp5HGovhLP93Jls5UNTf4lKzVYvcfULAU2qbGO7Lb15UTwdxE
	 /4JScRd843z/oMhvwbvg6T1fYwn1QjYFSw+Pi4WJi/0hGYf4UHHMa9gW0sfGOGsgDPFC+
	 NrpMafwcqFPt7QIq2orbpJOzm9VoRK0f7q2l7rLIp3QBSVrptNXOs7d1VAcZbdk/1nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792994472;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=MBhI4jv9cNfuwGNpplohOG2ETIzBr1ta9Zp83voofwg=;
	b=uqIQxsMAxBhGS0eZWnpdnTfdkMOSGVwWH+hweieQFrSLw9Y//Zsv30vZd6XHIOZEamso
	 rp1cmKxnH3AXmuHcSSgftxOX8Mj2dVV2SHJ0JCK/S5OLLJN66ogZ5anWE9AyZ1+MV6ryj
	 pMctWNC5UNdaKtihki+HqFMfcLRidqRR42a7SqgjKa5d0ahp2fnGShrxiI2NFOrbu1S2K
	 /N1+oNJyWAUd7ecp6Zek31uoJwmUPeXH5b5YVaFfnWH7NTxAe6MGpcjIaghA5y3yi4ZYD
	 nd+waPMm9YrXa7h8BWsnA7HroEa+vAL6BPGt7Mpl/OKoUpLkeKnVFLMsUu/lm/vhZ2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="jDMtrDN/";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DD7606A325;
	Mon, 26 Oct 2026 06:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62DD7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jDMtrDN/
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q2iaJx1991011;
	Mon, 26 Oct 2026 06:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MBhI4j
	v9cNfuwGNpplohOG2ETIzBr1ta9Zp83voofwg=; b=jDMtrDN/W9iNSRg67BjC0y
	fUoUeoz3XK8sgsGLBGKbYknf+jPthY+z91MvxtLN9h6YdTXxGzuxyBevuV66ZZam
	jrazXRbkLmQRyNW8JP7FU6OsaPLSmhC7Loas/qMNjHmGTEBJZgsXG4UXmhnTbkWD
	+ZB7zp2S7YLJKp+bufSdT9wI932VWvRcpZ9wATrDWn0jqYHQrm6jRFlanmferDZQ
	DxiUxtVedeGmX+hdU5vwZQF0DYq3Xq6NVz07B8o3B6W2g1z3KaAMHX6ZaHIDwI3A
	W8if7neSoOsxTKFa0fKW5jOAqnG7KMoH/ToiMCqMDGXMfMbhqr3W9UhrzTGS1oDA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd6r5me-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 06:01:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q2KQIg1924216;
	Mon, 26 Oct 2026 06:01:02 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8ggvbsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 06:01:02 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69Q612tO13828648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 06:01:02 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C5315805E;
	Mon, 26 Oct 2026 06:01:02 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D20F858054;
	Mon, 26 Oct 2026 06:00:58 +0000 (GMT)
Received: from [9.123.14.188] (unknown [9.123.14.188])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Oct 2026 06:00:58 +0000 (GMT)
Message-ID: <5756baff-990f-4c5f-b2c0-4a74bf2b56e2@linux.ibm.com>
Date: Mon, 26 Oct 2026 11:30:57 +0530
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: drain external refs before freeing a failed-init
 module
To: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
        samitolvanen@google.com, atomlin@atomlin.com
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, pasic@linux.ibm.com
References: <20261007083956.2488796-1-mjambigi@linux.ibm.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20261007083956.2488796-1-mjambigi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6adeeca0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=lsQSk-BVQFwOlMB7tfUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyMiBTYWx0ZWRfX8n2OyJqqVaLL
 nK5j1t8kBgqCoFe2lu8fNZ3v84sATQb0H3rByx2GfddmVgSuLfqB9MV+69YE0pMEQ4akVwqFg1M
 T6WirOiz3Kj+tGA9v71mvUwb8fgXKNWHweRUxeN9eaEBqHhcVPy40FSVINYpbTv4zYcSwlsRop4
 I/TKUs/j8CECZX3E8SZ/8N5xo+CL9HzbIyNCVTlrqk5QNEdFeYITA2gccZ//ON+gDG6UQ8SnDNY
 zg2S6QS/ivj/kJofnzxRYpGUwpXS3SYmqhgUvrXNvrt9/w9MoP+Mg/J9Ib3qz/VKI+k0AJGWpzb
 AaQGkYdxxDmlu9RwJjyVZTe+HVf6LGKmhLyLGMaroWZELoX7+oHL48AGL6ebjzG+WKzSOwHAGzp
 9zA+vxt3wlRT9aqUMnfwKCy3bYtDTidVo+zqNy3grG6yXXyrsygmGepgyHi3Bz3A9/SaVrRESoM
 8Kh2VoBVtlXFgKri9uQ==
X-Proofpoint-GUID: N_Tf-mWYZsQaFZHp4f3RZ4anFYYAhOsP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyMiBTYWx0ZWRfX7EBtpCblfygC
 tyM6bzGdK/ebu+WZLjl6UkTvhPDa6IvelC5qVBY/IAbRZ3TCo3J46CCZ//h/+h6NCzJbUgeOih6
 Rz4zetrh2CkmGIVxw4GTC9Zyj28McTE=
X-Proofpoint-ORIG-GUID: izxh6AesXzWeESc6LNhBHbXy0fJd7Yx4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260022

Hi All,

Gentle ping on this patch. Is there anything I should change, or
any additional information that would help the review?

Thank You,
Mahanta

On 07/10/26 2:09 pm, Mahanta Jambigi wrote:
> When a module's __init makes it externally reachable (e.g. by registering a
> protocol family or a bus driver) and a later __init step fails, do_init_module()
> frees the module while callers that entered through that interface and called
> try_module_get() may still be executing module text.
> 
> The normal unload path in try_stop_module() refuses to proceed while
> module_refcount() is non-zero. The init-failure path has no such check and races
> to free_module() immediately after synchronize_rcu().
> 
> Fix it by waiting for all external references to drain before calling
> free_module(). Add a per-module struct completion refs_gone inside the existing
> CONFIG_MODULE_UNLOAD block that is initialised in module_unload_init() and
> completed from module_put() when refcnt drops back to MODULE_REF_BASE and the
> module state is MODULE_STATE_GOING. The fail: path calls wait_for_completion()
> (guarded by the same #ifdef) after dropping the loader's own reference,
> replacing the previous implicit assumption that no external refs exist at that
> point.
> 
> Also move wake_up_all(&module_wq) to before the drain so that concurrent loaders
> blocked in module_patient_check_exists() are unblocked immediately once
> MODULE_STATE_GOING is visible, rather than after the drain completes.
> 
> Fixes: 1fb9341ac348 ("module: put modules in list much earlier.")
> Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
> ---
> Link: https://lore.kernel.org/all/5dc1fe2b-289e-4786-b9e9-e181dda8d4e9@linux.ibm.com/
>       [RFC] module: init-failure path can free a module with live
>       try_module_get() users
> 
>  include/linux/module.h |  2 ++
>  kernel/module/main.c   | 33 +++++++++++++++++++++++++++-----
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 96cc98568eea..0dee2ed02a2d 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -562,6 +562,8 @@ struct module {
>  	void (*exit)(void);
> 
>  	atomic_t refcnt;
> +	/* Completed when refcnt drops to MODULE_REF_BASE on init failure. */
> +	struct completion refs_gone;
>  #endif
> 
>  #ifdef CONFIG_CONSTRUCTORS
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c1b34dc1e89a..655c693bd8e2 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -655,6 +655,7 @@ static int module_unload_init(struct module *mod)
>  	 * refcnt == 0 means module is going.
>  	 */
>  	atomic_set(&mod->refcnt, MODULE_REF_BASE);
> +	init_completion(&mod->refs_gone);
> 
>  	INIT_LIST_HEAD(&mod->source_list);
>  	INIT_LIST_HEAD(&mod->target_list);
> @@ -956,6 +957,14 @@ void module_put(struct module *module)
>  		ret = atomic_dec_if_positive(&module->refcnt);
>  		WARN_ON(ret < 0);	/* Failed to put refcount */
>  		trace_module_put(module, _RET_IP_);
> +		/*
> +		 * If refcnt just dropped to MODULE_REF_BASE and the module is going
> +		 * away due to an init failure, all external references are gone. Wake
> +		 * any thread waiting in the init-failure drain path.
> +		 */
> +		if (ret == MODULE_REF_BASE &&
> +		    module->state == MODULE_STATE_GOING)
> +			complete(&module->refs_gone);
>  	}
>  }
>  EXPORT_SYMBOL(module_put);
> @@ -3206,16 +3214,36 @@ static noinline int do_init_module(struct module *mod)
>  fail_free_freeinit:
>  	kfree(freeinit);
>  fail:
> -	/* Try to protect us from buggy refcounters. */
>  	mod->state = MODULE_STATE_GOING;
>  	synchronize_rcu();
> +
> +	/*
> +	 * Unblock concurrent loaders waiting in module_patient_check_exists() on
> +	 * module_wq. finished_loading() returns true once state is GOING, so they
> +	 * can now proceed. Do this before the drain below so a failed init delays
> +	 * only this task, not every other loader that raced to load the same
> +	 * module.
> +	 */
> +	wake_up_all(&module_wq);
> +
> +	/* Drop the loader's own reference taken in module_unload_init(). */
>  	module_put(mod);
> +
> +#ifdef CONFIG_MODULE_UNLOAD
> +	/*
> +	 * Wait for all external references taken before MODULE_STATE_GOING became
> +	 * visible to be released. module_put() completes refs_gone when refcnt
> +	 * drops to MODULE_REF_BASE. The hung-task detector will catch any module
> +	 * whose error path leaks a reference.
> +	 */
> +	wait_for_completion(&mod->refs_gone);
> +#endif
> +
>  	blocking_notifier_call_chain(&module_notify_list,
>  				     MODULE_STATE_GOING, mod);
>  	klp_module_going(mod);
>  	ftrace_release_mod(mod);
>  	free_module(mod);
> -	wake_up_all(&module_wq);
> 
>  	return ret;
>  }

