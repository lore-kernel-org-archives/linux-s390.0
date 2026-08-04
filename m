Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99BA3D955D
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 12:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847635; cv=none; b=iyIbEUun3fiO0NKiX/fL+uGFshmP4qSGRyf2bdfCG5JOurFjweRG30Hb8y150lO+mChkw/jz00EuuKRLJg0nt42vxzfQq4lJ9uTMcYSqCJsEPgtb/igba3ygLVyrGhNwrVkfbbo/0Q+5oJans8U0ZaNfqVmKzvTXi5Yd1rFxN7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847635; c=relaxed/simple;
	bh=yRVBxJjJTMEAn//BGHF2EzYlvvJ9m0JzG8rPs84KBi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yxo8u2UyX0Cn0OE3IUTKAxPjaFemI3tGb2K4N+mKE64oXIg1RIaDZ2BI3D/CYwwboVpu3TvNDON7HWUealRPwCHkhdFCxHQAOU4cIs3Ckn/H+3V1xxVhWPTooU7AfgM/sjrLOQ42rzxHU9E7HjMomz7QgHmaWhGDgSoXqAzd/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bpRg7CSl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bpRg7CSl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748HaPW2640270
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 12:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=67e9BPtqE+vsPfTpS7wSJjqE9ALjiF
	PTS2qnEyTM/zU=; b=bpRg7CSlq6LkjoYq63vwJEYHoOY+aNcybN3Rb0tAU+T/GS
	UVbZqk+yJT7DSMJGajUCJnEL4o011SZHsFUEQUIpAcX0xL4GeRp1c+Ao1w33TCn3
	Asx/aqQo8Ak1a30vr4/QlfnD8opJItnA8yNJxzAT3BO+fK1lg7EcVEDdADZP87L1
	mD3RACIkMPXKV+TQOmoEVd2+RNMNhT1j5h0Y57X+DSeESY3oTDN2HTd04mx+VbHb
	kWjl1bKoPwIx21CX/h1WP3k6He0fD1HJ5yDdWWU61OVS2Hm7HPKoPL5ypo57tQH7
	9Jr7Ud5xG98cEDECZZk1zeBOl9hOltDD3cMM0FKg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqnswp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 12:47:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674CfbT1009431
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 12:47:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg9r7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 12:47:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674Cl7cs37617938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 12:47:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FEDE2004B;
	Tue,  4 Aug 2026 12:47:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 415D920043;
	Tue,  4 Aug 2026 12:47:07 +0000 (GMT)
Received: from osiris (unknown [9.87.143.152])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Aug 2026 12:47:07 +0000 (GMT)
Date: Tue, 4 Aug 2026 14:47:05 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 2/3] s390/crypto: Rework ctr_paes_do_crypt() to remove
 conditional locking
Message-ID: <20260804124705.12261Cbe-hca@linux.ibm.com>
References: <20260804113736.1423667-1-hca@linux.ibm.com>
 <20260804113736.1423667-3-hca@linux.ibm.com>
 <20260804114701.54ADE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804114701.54ADE1F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XOC3poYnXqyMbJHsDn6QyidKIqPVDUYe
X-Proofpoint-ORIG-GUID: XOC3poYnXqyMbJHsDn6QyidKIqPVDUYe
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA5OCBTYWx0ZWRfX/TE+jE4noEye
 swIRxJ87zD4C0o4oPEw2X3M0DQHVI8apoPQm0pEOj/T+11uKQhTnPmrIFr8OXJospGXcSg3MBVQ
 fqSimmawvoqABiaWzmZBYqDfViUCyQc=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a71df50 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=vmP8kJwS2AODcW9S08UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA5OCBTYWx0ZWRfX+LRa4eP9T/Wx
 XK1SDhzKtFmhlL7ezSLMINukvLvWg1m6jCT1YEqttXnOfTM+shUe6Y16Urs+d49jEwH/rP39Opm
 tRWSmzDzG9L7Sqd/ZKrckTdwMGnqM3zQVjhCf3ob2eDoJIHQ7L2V+a7BlZMh/RCGKd0bO3dc0JR
 Pf6HNiK/dCbXMNTKaWNiFAPEkKvzngrKgqQIo9hj/5UOtghbv1rnX85nSHNycmLecgNV2/ZAfP+
 Zq9cavf5kvDHmgnATtONAJRdDK022UD9LQIIcGLEDdl6V+Bf32wWlW2c10Q8UCvb543XvmxVx3I
 xaOhn9Y0TPf/GzuMvbtDQjbtaPSmxhSLJrhmOIte/ktwa8dV6StXxSkXY7lgJuQcQLBzF+QiKoL
 C+IpXWiEBEb5FOANvaTA5nW+TFOg84hXg9q24UxrpM7hz26mmsEHROqpHRiXd+fnkHREUBJb6qD
 CyzuUaYPEj9bU6P0wLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040098

Harald, Holger,

> Pre-existing issues:
> - [High] Silent data corruption when skcipher_walk_done() mapping errors are overwritten by paes_convert_key() false success.
> --
> 
> --- Patch [2]: [PATCH 2/3] s390/crypto: Rework ctr_paes_do_crypt() to remove conditional locking ---
> commit fd135aacfa5dd1086ab5711e4513f6e0edede1dc
> Author: Heiko Carstens <hca@linux.ibm.com>
> 
> s390/crypto: Rework ctr_paes_do_crypt() to remove conditional locking
> 
> This commit extracts the core loop of ctr_paes_do_crypt() into a new
> helper function, __ctr_paes_do_crypt(), to avoid conditionally taken locks
> that trip up Clang's static analysis.
> 
> > diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> > index 8cfe6166c193c..d4a9108d39f5f 100644
> > --- a/arch/s390/crypto/paes_s390.c
> > +++ b/arch/s390/crypto/paes_s390.c
> 
> [ ... ]
> 
> > @@ -981,34 +955,76 @@ static int ctr_paes_do_crypt(struct s390_paes_ctx *ctx,
> >  		k = cpacf_kmctr(ctx->fc, param, walk->dst.virt.addr,
> >  				walk->src.virt.addr, n, ctrptr);
> >  		if (k) {
> > -			if (ctrptr == ctrblk)
> > +			if (ctrptr == ctrblk) {
> >  				memcpy(walk->iv, ctrptr + k - AES_BLOCK_SIZE,
> >  				       AES_BLOCK_SIZE);
> > +			}
> >  			crypto_inc(walk->iv, AES_BLOCK_SIZE);
> >  			rc = skcipher_walk_done(walk, nbytes - k);
> >  		}
> >  		if (k < n) {
> >  			if (!maysleep) {
> > -				if (locked)
> > -					mutex_unlock(&ctrblk_lock);
> >  				rc = -EKEYEXPIRED;
> >  				goto out;
> >  			}
> >  			rc = paes_convert_key(ctx, tested);
> 
> [Severity: High]
> This is a pre-existing issue, but does this sequence overwrite an error
> from skcipher_walk_done()?

What should happen with this? Can this be ignored? Or should this be
fixed like

  			rc = skcipher_walk_done(walk, nbytes - k);
			if (rc) {
				if (locked)
					mutex_unlock(&ctrblk_lock);
 				goto out;
			}

before the conversion?

Even though I said I don't want to fix pre-existing issues, I broke a
similar code path with the first patch, so...
