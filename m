Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AED5217658;
	Thu,  9 Jan 2025 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736431019; cv=none; b=V845i4Zn0jJsL1Nr4ttsjrphjr/bwCpXwLtqfZ4olv5JxiothVXaYHCaK4reNC3HP/mY5B1Wx7D4AOb9hoELztZDPqK1xqQepEVwgpysrm3PZgLnsJyj9d9BYP2/MtN00fphNEhemhXKm9rbkn8nerWwrBj8D9DDc/C9LNEN16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736431019; c=relaxed/simple;
	bh=I1FnGv9QxuuVXQd2hvWrSLiDxYMVYDOxwxrUfFDH8v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX429ym06UawzaNYp5dtqWaHT7Dse2ZZvzbTOEfzlNpInIj3WRo5HvDl2iuxRfWvuI/Njws0P19OiLy4j6y9XICIC2hIbX0n56xilVx755aSmZqi2EfqeEtY9GUNBfuJ8Idi+qwFzDM9hHA7eW0qRD4GT0iVD+iNvixK+FFW8Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aL7CYv6O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aL7CYv6O"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5093rZpi020448;
	Thu, 9 Jan 2025 13:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5Imj3W
	uC3h4hfNpSStr5irgt9ma+NKz1CvpBeyjYdY8=; b=aL7CYv6OaKYNAot37pJ/1M
	0osNDLEAuYJckBDb2yV0LOtgZlSQGiQGp+F2uP5GXu1V+pfXtDjZ+vxUL+J09LQf
	oHajqK6E6tW13tyRFLjmUZXz5x2jCRmScQrVh0HWHJXOvlBhls2bFvsEmoRqfZRi
	HiKWh4+eSqTkR9kbg1fA7poq8DzL4hV+fp9nQ67iYAkPLZbMsk0UTq5uGk6Up6HV
	7Qysr+b5aWNArs7gsz140O2zoP2vSRtg0VYAaIAd3M8oet1Sq+3Ze5PZPtpw/k/m
	q7xs2f98TucHGlvH/IdXZnMW2G58HWy4rCivCyZ5J6rQ5e+b9G/fiG8KoYK8Tw3A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4426xqtenv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 13:56:53 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 509DjHcc022622;
	Thu, 9 Jan 2025 13:56:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4426xqtent-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 13:56:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 509BbNdb008875;
	Thu, 9 Jan 2025 13:56:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfq05gh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 13:56:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 509DuneS53412138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 13:56:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C55FF20043;
	Thu,  9 Jan 2025 13:56:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A57E920040;
	Thu,  9 Jan 2025 13:56:49 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Jan 2025 13:56:49 +0000 (GMT)
Date: Thu, 9 Jan 2025 14:56:48 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Weikang Guo <guoweikang.kernel@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] arch/s390: save_area_alloc default failure behavior
 changed to panic
Message-ID: <Z3/VoAaSQF5Tcy4t@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250109033136.2845676-1-guoweikang.kernel@gmail.com>
 <Z3+ECLf7LHQe+Mdq@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <CAOm6qnkoKjrUXCbhCiSYviuwCRVES1FYCy17fwATtyZ+M=Aw7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOm6qnkoKjrUXCbhCiSYviuwCRVES1FYCy17fwATtyZ+M=Aw7g@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dvW7Zb62a55HhUZ28NQ3J4NWuimYyrKF
X-Proofpoint-ORIG-GUID: 70CpqTxVOhstidpyPtjoBBewF19DMKTL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=740
 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090108

On Thu, Jan 09, 2025 at 04:28:06PM +0800, Weikang Guo wrote:
> > This patch is a follow-up to v7, but instead it needs to be part of v8.
> > I guess Andrew would refresh mm-everything (or whatever he finds appropriate)
> > with the new version.
> 
> Sorry to confuse you, `memblock_alloc_or_panic`  is already merged
> into mm/mm-everything
> by Andrew, so this is an additional patch specifically to fix the
> problem you mentioned.
> 
> This patch is based on the latest mm/mm-everything branch, and it  has
> also been merged
> by  Andrew，You should have received the email.
> 
> @Alexander  I hope I cleared your confusion.  ^ ^

I do not think I am confused. The merged patch is not good enough for s390.
This patch addresses my comments, but it needs to be merged into v7 or re-
posted as v8.

@Andrew, is that still possible?

> > @Andrew, please correct me if I am wroing.
> >
> > Thanks!
> 
> 
> Best regards.
> ---
> Guo

Thanks!
