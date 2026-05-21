Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6812E3D966A;
	Thu, 21 May 2026 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368756; cv=none; b=tX3GEuof9jngSyJcemvjpyh325/RfAnQWUyHuLWjO9wt3m6fuauI/nwW2dsZ6tMsOZQLocMFNqZvxXLT8LNI2bFrsdxUSKjGkG18WQ+jtXtnh5IX7Dh+4JoAMNUMOgiQmIY3HH/q79h+BFwnWrcspMhxqncp0FCy2PWTuCGxBUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368756; c=relaxed/simple;
	bh=SaMbTE3SaJK/sdJh47kfNBMWhl6qoTz8OqKV+2aenvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtsNmLGwwqQnQkbGU7y/rdfyfmv+02wFQX5NTPo2eixYPhvu5f5aYMh9oWUejZmuywoeKMGK4sQRptmuixW+Fn5hJwmCoxLh1XhbIiOhgWYbiQbXy+L+d9hHLIKhAW1ImciijICYJRCnzkJl6x9upBEIASi++IN12TCeVW4sxFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BdJJc6tD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BdJJc6tD"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LC6nwD2166376;
	Thu, 21 May 2026 13:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SJmxqkEDQ+jFtm1Om
	IP7Y2QFjYJmvDDcjNPrPs6X0Vw=; b=BdJJc6tDy0uYl9Ow59luDJr2TPJbpLi/i
	Sk533QQmpFwEJNVugjd5AMf24Sj7yZzmnG9D04ga6zWraxJvn5Xt762bWAJTFZWv
	peOLc9K5arEe7HD5tecAdrElnJ49HrUANGk4nKETPXpowN+Kai8FB64YVACud0DF
	eRrSm9Ev3blDZ/syrWGf6W3ii7SLUeAfxshZ5iuIJumtbIH8mgm9V3w9F6ALUYtp
	Ro24IQnk8jmudnch9gXxlD/ATJNK5eEd6/4gGsl928JmfXkmJnCQBeAHfnFGSLn9
	TX8aLe3M+67SoB0S95kLl5NIkXSB15jehsaj4EX4dA5Ca7Yj+QFiw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h756ytr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 13:05:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LCs6LY028579;
	Thu, 21 May 2026 13:05:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kybwxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 13:05:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LD5YGX31261088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 13:05:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F29B20040;
	Thu, 21 May 2026 13:05:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 402CC2004B;
	Thu, 21 May 2026 13:05:34 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 13:05:34 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, yan.y.zhao@intel.com,
        isaku.yamahata@intel.com
Subject: [PATCH v2 1/5] KVM: s390: Track page size in struct guest_fault
Date: Thu, 21 May 2026 15:05:29 +0200
Message-ID: <20260521130533.156491-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521130533.156491-1-imbrenda@linux.ibm.com>
References: <20260521130533.156491-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0f0325 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=HydwJh4hHmF5zmZ3e14A:9
X-Proofpoint-ORIG-GUID: DZbXDkbKjzRpQ523im5tC0gtKz2IWN3X
X-Proofpoint-GUID: _ZircIAaRkx5g0A3L7Za8Z5zgqe8p6ol
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEyNiBTYWx0ZWRfX8UGLrXnVvLcv
 GrhvzhanDZVg4882rN2YpBzGHCx0K2OSFGoSTfzO/wGSlQYqJvBkzink4ksOaFs1TIfqY1WxweE
 zDY9xKVqu+gXjtuhvxuXcUZHotfFpzrGMf42hgpFJX13StCzmOByyQdbRR5CNDDx3A8omSYok+H
 CCTyjOgaz9L8PAZY1T1FRut1QbUL6NdkBjkjktkj2TmhyYie8MxTmq9oCFOtSFr/GnWo8nDELOh
 IMOutZe/hLTwQbKOTKMn0gfLsuH3fLxsa7FNazEbj/qvge4wmb3P2oJhalYUbKPnMAoqOFuauRg
 4rLL2jUVnn6Zt3CD47g215hbD/t+vqDAEBfqKgWE43g7AOePsBtRY1KhZSCImtWK7bpWahmPaBF
 zs1quP+fuPzY+1D9bNLtQeOqa/qGKwnnxFXlvE2Fcu3XxEA/M95L+gkGEhBYJ1CHtqe1EkMkhZ3
 pFJYtqVL6kQHUgIwJBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210126

Until now, the members of struct guest_fault are always accessed while
holding the required locks, and thus the ptep and crstep pointers can
be dereferenced safely.

There will be some new cases where callers of kvm_s390_faultin_gfn()
need to know the size of the page used to solve the fault, at which
point no locks are held anymore, and dereferencing the crstep field
is not possible.

Introduce a new crste_region3 flag for struct guest_fault to indicate
whether the crstep used to solve the fault was a region 3 entry with FC=1
(large pud).

This allows to disambiguate all three possible scenarios:
* If ptep is not NULL, the fault was solved with a pte.
* If ptep is NULL and crste_region3 is 0, a segment entry with FC=1
  (large pmd) was used.
* If ptep is NULL and crste_region3 is 1, a region 3 entry with FC=1
  (large pud) was used.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.h  | 1 +
 arch/s390/kvm/gmap.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/s390/kvm/dat.h b/arch/s390/kvm/dat.h
index 8f8278c44879..db09b8fc34d6 100644
--- a/arch/s390/kvm/dat.h
+++ b/arch/s390/kvm/dat.h
@@ -500,6 +500,7 @@ struct guest_fault {
 	bool write_attempt;	/* Write access attempted */
 	bool attempt_pfault;	/* Attempt a pfault first */
 	bool valid;		/* This entry contains valid data */
+	bool crste_region3;     /* Whether crstep referst to a region3 entry */
 	void (*callback)(struct guest_fault *f);
 	void *priv;
 };
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 3c26e35af0ef..6f4143092871 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -545,6 +545,7 @@ static int gmap_handle_minor_crste_fault(struct gmap *gmap, struct guest_fault *
 			newcrste.s.fc1.d = 1;
 			newcrste.s.fc1.sd = 1;
 		}
+		f->crste_region3 = is_pud(newcrste);
 		/* In case of races, let the slow path deal with it. */
 		return !gmap_crstep_xchg_atomic(gmap, f->crstep, oldcrste, newcrste, f->gfn);
 	}
@@ -690,6 +691,7 @@ static int _gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, int leve
 			if (oldval.val != _CRSTE_EMPTY(oldval.h.tt).val &&
 			    crste_origin_large(oldval) != crste_origin_large(newval))
 				return -EAGAIN;
+			f->crste_region3 = is_pud(newval);
 		} while (!gmap_crstep_xchg_atomic(gmap, f->crstep, oldval, newval, f->gfn));
 		if (f->callback)
 			f->callback(f);
-- 
2.54.0

