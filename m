Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F082F60CC;
	Tue,  7 Apr 2026 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775566545; cv=none; b=KQ4OJ+j+IftGC9Uv3SCWrvBSwfX4TYIWMyxnfLgU7ba8RzjVRb4WvA7a3KozJIuUz+xspdnbdY5T7wKcj2lsAUtelTfd9RjnC6Zthn2UPRsVfTkVqvp/MK39TCdf+yTGoSzUzn17L0W45cwj00sJ6qfciFNpKwGeID+HpCwrc0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775566545; c=relaxed/simple;
	bh=X0NAYw8PHkcAA7/vDABIUI1eRXVSBm0Twe24hMO2tLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=po+fBHMy1pINiNKtcyMh/EUYy3WL1vj8RZLty7LwUIfIF4CT6/pYwxiDPmhHYLKIzLE56yTxKwEhQPwcnVtWgqYI9+44iQ8A5xUfmk7O3sqDRSv79xs60HkOqFQ5YMFw6E0EHQFywZhAZEPpXKNzrID850ZbYrkGGKk1Sk4E+Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kevrAzuI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kevrAzuI"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636Lml5v2212474;
	Tue, 7 Apr 2026 12:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=QF7RaGEnmRSGqFsRtbPkdAnLSg7Emc
	Tvt/R7oN9NVm0=; b=kevrAzuI+DMkOqnXUPeKW6Ao7zkLP1xKQIjuTPwnhDp3ph
	45u/F/No1wZd2+mLKNSRuw9WDavtPMKvXtW0AaQ4Upx9TSz8aawk8GMHPug53+NZ
	3knlJFGUUQ+1B5bWmhw8M+NPs7BZzWZBraVMRntZaAKWeTm6nxkom8mkqhE/60Vo
	F1xqviI0qUAgyLvBB2TYsOC3vP/YLpPpWzuqlAzKRPNklcVNiIgrEgMcxyX2Il65
	WTto3bPnSR0Z6n9zYkLxT6Om/Mm/ZDCm5hEz3GhYUrei247eEit4l/SkG1KiL47R
	Ax7GOU5O/v0rCMHTVUp9SR/MCVwACT26DIG4BhOA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2haqjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:55:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BNSk7026655;
	Tue, 7 Apr 2026 12:55:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg7u5v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:55:40 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637Ctam753608790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 12:55:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6F7A2004D;
	Tue,  7 Apr 2026 12:55:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93F5E20043;
	Tue,  7 Apr 2026 12:55:36 +0000 (GMT)
Received: from osiris (unknown [9.52.216.133])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Apr 2026 12:55:36 +0000 (GMT)
Date: Tue, 7 Apr 2026 14:55:35 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, david@kernel.org
Subject: Re: [PATCH v3 6/6] KVM: s390: ucontrol: Fix memslot handling
Message-ID: <20260407125535.296205-F-seiden@linux.ibm.com>
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
 <20260402150135.196943-7-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402150135.196943-7-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyMCBTYWx0ZWRfX6WOTASxshn4N
 KJR4ZzIPxcuexvOK6SrnoyOKQ76Gu7J7hOyQaAnEp7vVAUXGukT8cPfAnuEBiaHtTteRVVtEFuP
 hk4ElU7r7IXA8zvyO9EjnjpFA674pAfyeZV4qVdnczLgBzSvL4os2gRVjur29+2uxpr7yThjHWQ
 HkXCgLfBMic118cMIATvYc+Ma+3HIDEe/QXHb37Ocww2LrYYjL11Edj0LG0MVT3Ab0888zK+ILa
 0Hi1Bu22U8qDMC80xrbdLf+CgtRqqQDQk2G+Am9m3DreM6ETOtdiCFVvvNg4LHDFeZ1G4pk3E01
 mg6aBnj8eJjfvsQNbwRSpLQVUHkOqgRjXWcZikaglwha3IRIXucM1pWUh/iuYzQs7bCZt+p0tQN
 ER2DdTv+qsgX2WXatJhdfbNTARWc0Fc3TFYkbHV0/Bd/ndfyVqxc/5tN5MVDWv4WFifLOszlofj
 +q7SGR22qpD81MVxcWw==
X-Proofpoint-GUID: 7DYn8GN-AjNXmSPrSCXpj-xB3jrUlQS9
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d4fecd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=aQ1MGpRKgc2xMckM4EIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 7DYn8GN-AjNXmSPrSCXpj-xB3jrUlQS9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070120

On Thu, Apr 02, 2026 at 05:01:35PM +0200, Claudio Imbrenda wrote:
> Fix memslots handling for UCONTROL guests. Attempts to delete user
> memslots will fail, as they should, without the risk of a NULL pointer
> dereference.
> 

You may want to spend a fixes tag:

Fixes: 413c98f24c63 ("KVM: s390: fake memslot for ucontrol VMs")

> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

	Steffen
