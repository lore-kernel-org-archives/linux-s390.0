Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6749B318BA8;
	Tue,  7 Apr 2026 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565023; cv=none; b=k2z0ryHlnM7HJxO5TGaI0u9bcOl5bp4qhjQLXY7eBbq/bkCE1txOwHVvysJxtCBzaG9hh6Qi3ON7V3CjVCB+oxQB5JQnZFL54bIE85dL5CU/0XsuQdXZMHHrgtx94S0RjlGzvW84q322Fpe+v7paYSN+8ucPe4FpzbmYSi+tbgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565023; c=relaxed/simple;
	bh=cmYDDCMHMcBTRDryegl0jyOpg1KRl/Mg//Y043RR2JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuMCkZN35Ve9+oQucBB5dlt3h4nmcNH43P1jW4Hb+4VRdEDYw5oc1KU9PE2TSRfDbcuM+c0C96FApCo3/j7Et6SnxdGxFMBI27S78X1Huhrl8poLtPPc/Ylv5/MG5x8YmPJPudts8FJv7+eCBH0X0GfNzE3QnuMy4M29BVH9VvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OTvmtQEo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OTvmtQEo"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636Llii72297379;
	Tue, 7 Apr 2026 12:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=g5yzOxWSa8zvRbce2TwOvbuGXd5hRR
	xiY16YUlhyYyc=; b=OTvmtQEonzCm+cWXMgL+SGxOHP1iTW7RaDQRXJKqKcAXW7
	V5zcNLe4XNqUKzzGClb69jUqHgFsIcaiGB+HmnRBNdpubRTGThuNpO47wico2YzI
	iNJu8T4JYrNVL8XwyARA4AeBZ3VnjzYMw7SYQ8dDYFsgmYOzk5qGiUp8KBr9DQxg
	TqlmLSLTb/QsQJpGEI8RoxnpFx5VqqCN9YzEYyGZu0VUfnt9ET64Vtqv7noYEpFk
	RZ1A6zePrXAbAZXU2yQGpa/QyxTkAe7B+Z8JiFRF4u4l55MZmA1eSaF47T7wFwlE
	dQwPvF5bSZRB5rkMmVb17yNID+wekcmnqokVXfqg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2ftmav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:30:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BWbkt014378;
	Tue, 7 Apr 2026 12:30:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4k2an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:30:17 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637CUDxd30999252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 12:30:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A261920043;
	Tue,  7 Apr 2026 12:30:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D5342004E;
	Tue,  7 Apr 2026 12:30:13 +0000 (GMT)
Received: from osiris (unknown [9.52.216.133])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Apr 2026 12:30:13 +0000 (GMT)
Date: Tue, 7 Apr 2026 14:30:12 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, david@kernel.org
Subject: Re: [PATCH v3 2/6] KVM: s390: Add alignment checks for hugepages
Message-ID: <20260407123012.296205-B-seiden@linux.ibm.com>
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
 <20260402150135.196943-3-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402150135.196943-3-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d4f8da cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=IOgtwTkHqvAa2c77OGcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: h2MP0EUOrypcm--nW8ayEudu4M-CWPeJ
X-Proofpoint-GUID: h2MP0EUOrypcm--nW8ayEudu4M-CWPeJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDExNSBTYWx0ZWRfX1YfSRDDQeVAQ
 mzCZSkED78HMFvhBHAQ+hUPhZRB9i6V8VOsiIpuxnAcRmThKG2CJmZl1Ox0EUyiU1LbPcQBsJ11
 vg051WVYI5URpIdis3IJwyvSio80N8BVkLxZRniM6ijFz+d2S4MFu2FRhK/Ectfx0rGJg7iwY7S
 kdbcIb3Jye0J0R6skVaMBDyVTqFc8W2xy5/7F42q2DqoKstW5+9ngGW0+2TDFMnz2NhEJYiDMJH
 N3VAUQ47KY0f7Uui38SM7GNSy5v38Igvso5nf1jKHvusQId7Jrm0grinc9LOv8Dd5ZU8l9AIrHr
 oKFhW8uAsU9mqPqP2fW6xBkjl0TxbNGJ8asadIpc+OJdb2pLV9/AFK94JvJZhBXWRU28qD5q3H7
 pZimAaqLWa1m8/KD02wOiP2OvLohq7HRoKegr4YxkyN8tWl/oQB908W2SV2vAXrHnQyojj0eJQt
 1ORANPsaagypHpfF91A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070115

On Thu, Apr 02, 2026 at 05:01:31PM +0200, Claudio Imbrenda wrote:
> When backing a guest page with a large page, check that the alignment
> of the guest page matches the alignment of the host physical page
> backing it within the large page.
> 
> Also check that the memslot is large enough to fit the large page.
> 
> Those checks are currently not needed, because memslots are guaranteed
> to be 1m-aligned, but this will change.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>


