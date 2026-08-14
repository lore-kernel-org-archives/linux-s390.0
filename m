Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6062B47ACFB
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718502; cv=none; b=Ov1GqhORAOWy/HFwzL6p/XxEQkQHwwU+LI3A5wVHfupOwxNTnZhvx3FEx79EGsR6UgInl87mpuZFaUi8DFHdbS23Cqi+7kgMJE78QL/gU1HE4mjW/56aRBWZTPD2tALlrhiHmKPEKJp3W4DxVjmV7L/F09LkxsV/ejsE9FAU2/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718502; c=relaxed/simple;
	bh=nykLhtkDorzGikFc+l+tun2q4Xq5nKqpMvtVJ8CiD7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enmzaoUhmt+YIgdg2U9+ltmoIBumEkKY9KgfKaPHVeUZpgMLqFCmLYOrgWNEam5eqY8BOrR8oqxPeO8ViIu6qqC0KO/vWr3khh32gFya+tItILCVEcI62NE2/fZpkE/tsgkoPQgW4WnkpLjMGOvC8CbE7PA6PQsoeGRjgLP7YYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IawkhuNf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IawkhuNf"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EE5ngB1343028
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 14:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7JWE71XjvOOtLigiTmeJ1keHL/zaC5
	dWKeP4EDb5kQw=; b=IawkhuNfz/GBRiVsOAuCbhGGqjEYwN9DUFUdWQDYS92+f+
	batjw5Z5r3WgC87cVkH176FROqtPftcsdulZNJGVotfxkE1rWaEybIhcDYK8NWKw
	uNrs0WU/4HO5q3EY87ydGeMO/RU07ZiVNLOF07+2UZg11THqW6UiGEmogxpNVlxn
	0Owgb7otvPSo3OR87bzpsNzY1PCWBt81zrMiXaFG6wXD3hhcHvv5O5bDZeyeb+LH
	2pVcYLOhw7S2iCTzhSliVWc8MWwoGJV7x8w2zArYwRsrs3MSV/Nju4ou1LHzaasa
	zvMJZdgw39EfMlY2WmQL872tWX5yF3ks5ZMJhx4w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma5b8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 14:41:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EEfI68001259
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 14:41:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gqhyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 14:41:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EEfZpl52363562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 14:41:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D30DC20043;
	Fri, 14 Aug 2026 14:41:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DE7B20040;
	Fri, 14 Aug 2026 14:41:35 +0000 (GMT)
Received: from osiris (unknown [9.111.40.200])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Aug 2026 14:41:35 +0000 (GMT)
Date: Fri, 14 Aug 2026 16:41:34 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] s390/ipl: Fix NULL deref in kdump without re-IPL
 parm block
Message-ID: <20260814144134.135106Adf-hca@linux.ibm.com>
References: <c00-02.ttjpfvt@ub.hpns>
 <p01-02.g87de83845c5f.ttjpfvt@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p01-02.g87de83845c5f.ttjpfvt@ub.hpns>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDExMSBTYWx0ZWRfX+A4RVnr9YkON
 T7Ez1GiYUthS2Wo8/fDUDMLoe+MtWB1A91I1IhqYt02eu19wWXHv3lqL/XNaggfUkDp0wuhFVsg
 pY573efaTMVNuuD5Kbc5ugSt4BO/nJ1vJZGfc9NiE7k9wlI+XhRQNab6pjRzP6KrOefxLMBw5f6
 FtcbalyQckBfaGabXIp+k8k5Vse5/IONQKRm2W2o87OGML2JA6mHxfOEab/13wvsGFSJKiX5WEe
 kgdmI6FkDCgTRBLKJ65nG2ndtWHTf+TtnSSm/EUDAE9pvUhf1PyNKt2RlnJdh4X5KjDI3x4V5w5
 LrAVTLB+PY0MmGSbqPrgmDO2bCFTthmL9pW2NN3mr2wMkDc/xG1PsiVq94c3UybZ+w7uwy8wbnm
 qlfXFcBQBhGFa6oIYzhWcp/xqkSsF6zs4HGISV2CAKTz0QCeRdm4NBd8LvC4AejVgUrqdvRZ1vf
 ZvxQir2SbG0Nq6kRmeA==
X-Proofpoint-ORIG-GUID: 9SNSmtXsYIYhUhiQw1NfORbFjWbHyq4Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDExMSBTYWx0ZWRfX48FoH2IUAoxs
 rM/eap7c474UHjYEbhFJh0jpJKlMHBSH3NYqzlK1fG2uTVINpRlZqxEJ5OHRijtt3mXBaGTBz8S
 LJBj8trusvBu86qnB+Fd4DrjIlAg/n4=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7f2924 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=wlvK-vJGsJdvzziIeEIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 9SNSmtXsYIYhUhiQw1NfORbFjWbHyq4Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140111

On Thu, Aug 13, 2026 at 01:06:54PM +0200, Vasily Gorbik wrote:
> Some IPL types, like HMC FTP boot or QEMU direct kernel boot, might
> not provide an IPL parameter block. In this case, reipl_type_init()
> selects IPL_TYPE_UNKNOWN, and reipl_block_actual remains NULL.
> 
> kdump passes the re-IPL parameter block to the dump kernel through
> os_info. Before commit 3b9678472bab ("s390/ipl: correct kdump reipl
> block checksum calculation"), the os_info entry was added only for
> IPL types which initialized reipl_block_actual. That commit moved the
> os_info update to machine_crash_shutdown(), making it unconditional. As
> a result, set_os_info_reipl_block() dereferences reipl_block_actual for
> IPL_TYPE_UNKNOWN. This may happen to work by chance when address zero
> contains readable lowcore data and the resulting empty os_info entry is
> ignored by the dump kernel.
> 
> Skip the os_info update when no re-IPL parameter block is available.
> Kdump then collect the dump and reboot without setting re-IPL parameter
> block.
> 
> Fixes: 3b9678472bab ("s390/ipl: correct kdump reipl block checksum calculation")
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  arch/s390/kernel/ipl.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
