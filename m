Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78AE2EDD40;
	Tue,  1 Sep 2026 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261567; cv=none; b=rvrb8U6b2sko5IXcHOCAhD67T51NNlWzKnjuY8GbxJ2MDNwcUovW2exrUiKfE2KqK8W3RBjJjIeoedBClS07+PFLLAZAS3gU5I2EEAFqdd35t1Cdk9JJeDYiWkqmXVLOqZU6hGTlnxdKvDjCZS0Ypkc97+murakzOZ+0cQlpYfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261567; c=relaxed/simple;
	bh=O5/Gq4Sozrq8fxafB+wFsKxEued6lyFBeoF5ApaoUVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkz/HYaAXsdyDvnE0pOpveUVmo3byPrRIUT6G8QlFvQt9TA36aDAizgy0ieijCUHXAV05MXSBpHBvTqi/XvpDJTk9FQasvt/QKLOsWaLgYMIuwVWcSgQVrbkfCDTdyD8nxRlTNWBqBova8557txcKgRHtb8uMwOSZcon1mTu1DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nzQ1A9K+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nzQ1A9K+"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AVXkm3265893;
	Tue, 1 Sep 2026 11:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6FV5bMe4QDiQpLPzmmsiXUj1rxjFFm
	WD7IU07/i9G/s=; b=nzQ1A9K+7LN/GF9nfG14Jsh0WnTyv6AhPBkVdue5GneiZ+
	DGhulo9TJTPFced2+NlO+deH44iYBT35zF2hWKIMZN63SZOq1Pc6yhpYBPK68cfL
	Wby0idGj/YQDsaE9KMFLlE3tWMcNzupExBAvHAkN0TjR6it6QwwmhQBQS1fPUIiU
	QmuTSfDBjxd0UcLg20BZV1o/v2jBxW+cl1in8tJ1PEZ4fL9Zwdp1/cqFRDEgTZWD
	VqTW2hmemxQX9Aqtn0ewaWaCuBrY5by2wcyykUjHgQWaidqqh9Zpi2dbIgi3ur+f
	iIJUJ8B2KUICTthpyKTKDCC7ZS+M4DHl7mSS6xfA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r7bj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 11:19:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681BBJ0d024015;
	Tue, 1 Sep 2026 11:19:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygb5s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 11:19:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681BJKVI49742148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 11:19:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4A192004E;
	Tue,  1 Sep 2026 11:19:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE2EB2004B;
	Tue,  1 Sep 2026 11:19:19 +0000 (GMT)
Received: from osiris (unknown [9.111.45.16])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Sep 2026 11:19:19 +0000 (GMT)
Date: Tue, 1 Sep 2026 13:19:18 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, stable@vger.kernel.org,
        Jan Polensky <japo@linux.ibm.com>
Subject: Re: [PATCH 3/3 v8] s390/pai: Support CPU hotplug for PMU PAI
Message-ID: <20260901111918.14482C40-hca@linux.ibm.com>
References: <20260901085448.2260658-1-tmricht@linux.ibm.com>
 <20260901085448.2260658-4-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901085448.2260658-4-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a96b4bc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=dd3EgOEQJ-V_zgGiuFcA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA5OCBTYWx0ZWRfX24uhHMFkSSIy
 Y7x7EvEDiUsCiqMdwQvQt8x2wOADxOryc3uqVdoEt2JeLV1CF1GxXxrnqcanurJSLgpyn1x4bFN
 NVfLDgi/PbhyJW5NQlr0Se/jt/yWkUIJ0XkqOrExMZ10IVobOe08W07CC0SEXLfG2Shi0MQZIf3
 TIO2UMIKZNKVZNa0RjM3cd2ynwQ/BAhNpD70pe3SyXeqh8Tw3DkQzNlhtOD7Alofw9+D+H3sAjm
 QUYLEGLMH8b4/kuro7mYLc0SyNZMEki5/Aqeqp3Y1i2z8CkyjdJ9iKRJ3yrAcfDsc2HhxMmGtwj
 /KtpntZjZuxH7fyHXQ2mmn3Ew7PXFLZQyFj0ODjImZF62iApUEBxS7Yg+p1cfFVnM678K+4eBUg
 gaxUeQtS4eLx88vMZS7P1gWIAbJir85LJpxlOwgKkJcQ9HRXRuB8OVrWgbgqJIXlBgHoMzjh7v5
 8SbsqKwWV8EUBMdpfgw==
X-Proofpoint-GUID: -SzUILIe8VU6tbeuERS7DFg5vi4zNe3y
X-Proofpoint-ORIG-GUID: -SzUILIe8VU6tbeuERS7DFg5vi4zNe3y
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA5OCBTYWx0ZWRfX9UjTMdMHkzrd
 9BN0iu9EU5uNrT1f1BwB2te92U9RTcs9wCRe6KA2EyPAkh97YVdy/i2ndHPJlCKunnm8r85kRzn
 q+hl0yEE1XBtubl09DHrgKhxKbb02Lk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010098

On Tue, Sep 01, 2026 at 10:54:48AM +0200, Thomas Richter wrote:
> +static int pai_online_cpu(unsigned int cpu)
> +{
> +	int rc;
> +
> +	mutex_lock(&pai_reserve_mutex);
> +	rc = pai_alloc_cpu(PAI_PMU_CRYPTO, cpu, true);
> +	if (!rc) {
> +		rc = pai_alloc_cpu(PAI_PMU_EXT, cpu, true);
> +		if (rc)
> +			pai_event_destroy_cpu(PAI_PMU_CRYPTO, cpu, true);
> +	}
> +	mutex_unlock(&pai_reserve_mutex);
> +	return rc;
> +}

This unusual coding style. Please change to something like:

	mutex_lock(&pai_reserve_mutex);
	rc = pai_alloc_cpu(PAI_PMU_CRYPTO, cpu, true);
	if (rc)
		goto out;
	rc = pai_alloc_cpu(PAI_PMU_EXT, cpu, true);
	if (rc)
		pai_event_destroy_cpu(PAI_PMU_CRYPTO, cpu, true);
out:
	mutex_unlock(&pai_reserve_mutex);
> +	/* CPUHP_BP_PREPARE_DYN --> before CPU is brought online */
> +	rc = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "perf/pai:prepare",
> +			       pai_online_cpu, pai_offline_cpu);
> +	if (rc < 0) {
> +		debug_unregister_view(paidbg, &debug_sprintf_view);
> +		debug_unregister(paidbg);
> +		return rc;
> +	}
> +
>  	if (!paipmu_setup()) {
> +		cpuhp_remove_state(rc);
>  		/* No PMU registration, no need for debug buffer */
>  		debug_unregister_view(paidbg, &debug_sprintf_view);
>  		debug_unregister(paidbg);

Code duplication. Can't we have _something_ like:

diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
index 72023b35e70f..e1134e50f3e9 100644
--- a/arch/s390/kernel/perf_pai.c
+++ b/arch/s390/kernel/perf_pai.c
@@ -1316,20 +1316,19 @@ static int __init pai_init(void)
 	/* CPUHP_BP_PREPARE_DYN --> before CPU is brought online */
 	rc = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "perf/pai:prepare",
 			       pai_online_cpu, pai_offline_cpu);
-	if (rc < 0) {
-		debug_unregister_view(paidbg, &debug_sprintf_view);
-		debug_unregister(paidbg);
-		return rc;
-	}
-
-	if (!paipmu_setup()) {
-		cpuhp_remove_state(rc);
-		/* No PMU registration, no need for debug buffer */
-		debug_unregister_view(paidbg, &debug_sprintf_view);
-		debug_unregister(paidbg);
-		return -ENODEV;
-	}
+	if (rc < 0)
+		goto out_debug;
+	rc = -ENODEV;
+	if (!paipmu_setup())
+		goto out_cpuhp;
 	return 0;
+
+out_cpuhp:
+	cpuhp_remove_state(rc);
+out_debug:
+	debug_unregister_view(paidbg, &debug_sprintf_view);
+	debug_unregister(paidbg);
+	return rc;
 }
 
 device_initcall(pai_init);
