Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E057D2EF67A;
	Tue,  7 Apr 2026 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565893; cv=none; b=JoCJV9nAb9bBX+B8ecalDDsjh/nsvAMesjqQL4q/sZY9frElb4Q3VDgzgG6J8ZC2whbx1+BL3miO1kFK3RPqbOXWdheAfY9IVDDzjwugBVpXIRzDQ+R8vcT3J48HWWtgRvW6rb0x6FZ+WtUK/71H9oAsD+Nylioat3cZUsup9Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565893; c=relaxed/simple;
	bh=NipojrGlT+ECd+QfB2wH0LiET/bTP0kbLWQSU+eFAdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eER1FD10X4wpX5URcG+hhlM041WXPQRP13UTrkR2kR563uYMHD38p710FLC9IBGF0XMShYTfDr8zTMw9whWqJITFpV72uzVy/6kC/zVaQYIkxaeIsWbNrDZ2E6cLGjd76U3ayvWXKhrIur+craRuc4Z/zM7E2l8/v8K+rJ84UpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ci8812JH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ci8812JH"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LmiQZ2326709;
	Tue, 7 Apr 2026 12:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=slLMxJHkzIJNxe6W8sGyNjOthXEDKX
	Smx/x4rNCz3g0=; b=Ci8812JHSrqiNDlx8OVPGgQiIbxT3xiHEbdUxMN/fj3hzw
	VaCAsGcrCnunPsDEzmd0y63BMKcKpEG4HpBClA6QQ13ioyY+2QqbuhXA4staX/GN
	IfHs7lpMVR2remFenJKx6/PM3QyjOiSXuvgXz3CEyGsoYmrVpsoUbwHISKN2LJeM
	IfNuWoj5ppo/4a5TpRx1e7EYRBZfxpp9JTcAi1BnzX+XNt0F6zXF9YPz0if4XLaz
	PkMvqGXNURhkgMR1rEmD2vrSAXKiT9ILTfBlgR5+SaTx5RDTd9ZLAvCCXABI96iR
	1fHLXbfNI3xaAkZjIBBFcFOIZ08LHUgd4bCE9T5g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kapee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:44:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BO6BP013827;
	Tue, 7 Apr 2026 12:44:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf4350m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:44:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637CigRu14877066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 12:44:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F07AB2004D;
	Tue,  7 Apr 2026 12:44:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB2802004E;
	Tue,  7 Apr 2026 12:44:41 +0000 (GMT)
Received: from osiris (unknown [9.52.216.133])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Apr 2026 12:44:41 +0000 (GMT)
Date: Tue, 7 Apr 2026 14:44:40 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, david@kernel.org
Subject: Re: [PATCH v3 4/6] KVM: selftests: Remove 1M alignment requirement
 for s390
Message-ID: <20260407124440.296205-D-seiden@linux.ibm.com>
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
 <20260402150135.196943-5-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402150135.196943-5-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDExNSBTYWx0ZWRfX9l4c8hGg/rqB
 ea+bfvpC5whqdw2UxdnoJwWgiMTYE6pJP8ZVjanBOA0Aq2/msiUqsgoc0io2afm3dobTLLiDIKg
 5F8FvjYRWsLVg07mpldJ6E0Hwnhy/HdQjtHOwKJyUOpjdCP/9wGA9Amnw8a059CWxZMQm+bmSaN
 9PppNMS761mpt+KYhp6nX/TDFmrq2cIgu53fsSD9RdDd+Rp5Q/rjlRZweE+zJkTVrbnGCHJku5X
 mzthPc9QhrGst1ZQOHTGRoruhlEH22M3gutcFPoJdYzhrYozC/x/uZFSWC4VTbXeF6s6jLf7onx
 v+w+RrOZgP3aV3/IH9fznT6GZ6SW6ccFdIkL2IEzQEXL5ou6dlYxkdazUn1U+9bQA+BRp1uzolT
 Mr+C8vMfQbnQay1vqMwNete8ASB8cYYRndUjgdWRsTJpe6O7oSZuqQyfLd8LpWHOHG0Gjjeyl0q
 xf/yrAxCWhDQagcOAvg==
X-Proofpoint-ORIG-GUID: jCftGa8LuqYKoA3pNIC6yIgb1LqYkw3A
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d4fc3e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Gvd_ICUHSL6OjFKqTyAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: jCftGa8LuqYKoA3pNIC6yIgb1LqYkw3A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070115

On Thu, Apr 02, 2026 at 05:01:33PM +0200, Claudio Imbrenda wrote:
> Remove the 1M memslot alignment requirement for s390, since it is not
> needed anymore.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

You may want to add a testcase that deliberately wants to create a non-1M
aligned memslot. 

	Steffen
