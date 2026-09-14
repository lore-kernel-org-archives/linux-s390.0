Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BAF36B905
	for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789406327; cv=none; b=T4SpAs23n7dLH3hyEMQSSthn8oWjPkQVqHDmBbv3bmO3V6s95XffrMxhoW9m1HTINeIWvQirmOIeWYgjaJJEcp9JpRJqDj/A8ePOtvF9iosWHhS+hboYuN1e67BBbArEapxp0kLnRt3zwm6+RpG3EFsl1O1zd+AyIf0e5DxsQ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789406327; c=relaxed/simple;
	bh=mSNNs3otzA5pPBTVkCBhAYaqM6vJvit1zgr2+vIrN84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uq3978gC36plgDFLfECr7AckmHyn0fb8hlLvpEZzPJXOKeLS3CP4ZVhq6KOwIXdFDBnTaNyibyZNL/vLBTdZlQUXjfTDrmaQWoHMV+oSBQTJK2zch4n8M8wOakDDwo4qQGPPas6SLt2Z7clp5Luj0A+Voju9Z694npclDzyWn2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SozpLhMQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SozpLhMQ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EFvmxd1320038
	for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 17:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=rqr0FSC/xXwNrPEo4Ug3YcqGOx9mr7
	APeanIGW7sAKY=; b=SozpLhMQ13EiLVuqdUSTr6of/S5oMu8mZ/7wAn8CPZd+1l
	0Gh0UtfxrBRv2e9YJOJb2FeHx8sK7h0R7S4kOZ7d07C5TaXUpmXo4uNFkA1XC0xv
	RCRN+UBigRXXH0InSFJQ/Mnt8DBlSl38vGT47guIjfoEt7JSChN87pbdOerUJyOR
	wqDbaPFfuXvC/PnM5WWXVVwbFLp3/xHdNNBkwwG3qPhN72Mu5Ir7jK7wUK7cjZpq
	be5bUqAMATWdPWbs5Ne8fvlrKSb8iQ0T9k0Mw0TQP8LUvEW+BtgCXJDjBijUBawj
	vWoT9Ve/mchAdBulAD3wOnuDKlx+1fu3EfsifSOw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5dtua9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 17:18:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68EGY7al2352575
	for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 17:18:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnkry70g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 17:18:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68EHIdUp51052800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 17:18:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E054C20043;
	Mon, 14 Sep 2026 17:18:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 972842004B;
	Mon, 14 Sep 2026 17:18:39 +0000 (GMT)
Received: from osiris (unknown [9.87.150.220])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 14 Sep 2026 17:18:39 +0000 (GMT)
Date: Mon, 14 Sep 2026 19:18:38 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Euan Bourke <euan@linux.ibm.com>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, meted@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2] s390/hiperdispatch: use system_dfl_wq to reschedule
 hd_capacity_work
Message-ID: <20260914171838.14910E0f-hca@linux.ibm.com>
References: <20260911091309.1238604-1-euan@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911091309.1238604-1-euan@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI0MSBTYWx0ZWRfX+ajupE1Q/h4K
 PwjD2hls6RtkMZJ4QQaXNieBeEC9FPZgq4D0osfm3CFAem2IKeVF3S5P7Scc3f63BKpG+s6j9S5
 HGtdG8zKlj8YTYJ7kkRkmHxfCCS1qBcsP//kU/avIuHGftidkV65a4W8p8DDcfPSiMuuKsno4b+
 keQFhQ4e034L1xXZ8yg7RyFjX6CkM1f5ybadYApDTmfMv5cAzzpydoPCdxrh5dqAf332oat6hyK
 HNNYILOFeAVEDClt6af47X8K7L3vm07ruZs1Kim0pMkLkwH15s2PogU3UXonc+0/WBEVwIX6Qwj
 xzppWGizlNWNIYGJYyYRRPMlrOzvMsqDnhb//ydNO1+/IjemNow9i7jxrcR9NMtGWArCOXmbuq9
 rybok4Q8zsJyoPGMYiFAUOPAh/wl+Cuq9d3YJF8V3stSktoJrn0cEn7baK5EZVFOBVL9oO6iHtz
 FpvUE5kzb/4m4OkgXuw==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aa82c74 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=H_EcMzwd05W21IqyVeQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: V7ysZXklEYLWa-Ola2ZHoCL3bF7NR1HX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI0MSBTYWx0ZWRfX0DmJhlpYv3GQ
 thrX3RKykcDFCybj+/QeylytWhg0K4GNQzth+ZgMwBkaFC33zwSah7fi52KJaJGWSCKKueFeLW6
 Oqq2DAzjNFHx6BPk46+hUUPjVqMnlMA=
X-Proofpoint-GUID: V7ysZXklEYLWa-Ola2ZHoCL3bF7NR1HX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140241

On Fri, Sep 11, 2026 at 11:13:09AM +0200, Euan Bourke wrote:
> In hd_enable_hiperdispatch(), hd_capacity_work is scheduled on
> system_dfl_wq, however the work function reschedules itself with
> schedule_delayed_work(), which uses system_percpu_wq.
> 
> Hiperdispatch does not benefit from using the percpu workqueue. Use
> queue_delayed_work() with system_dfl_wq for consistency.
> 
> Changing the workqueue from system_percpu_wq to system_dfl_wq causes no
> functional changes.
> 
> Signed-off-by: Euan Bourke <euan@linux.ibm.com>
> ---
> v2:
> - use queue_delayed_work() instead of mod_delayed_work()
> 
>  arch/s390/kernel/hiperdispatch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks!
