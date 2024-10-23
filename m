Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E8E130AF6;
	Wed, 23 Oct 2024 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729688042; cv=none; b=lw9SdgXUa1RUeeXPi447mc0JW//W9p6yYzs/nSVBG+2mUBMMa01eAdm7BlhqX2TiW9xOxN4I6amINVn3s+q6wy3vycOcuI5Hx/aMz2BVZVBUWBzSKomFwYB0m+3hJ75eEcDz3KOrN9O0l+nBmDlv1GlJWP7pJSjBy3Ss4DY48VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729688042; c=relaxed/simple;
	bh=tXaxKqHuCg1Tvq9+YFI+ZgXBgan+kLSt1m1umb+dr9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqH3P6bK4o7ROVZnD1hGAACO18MAsUYqAu3N8MkYmBc8mYitwTdSRd/553zMl5D+UOzjK0bXjsEbVrMzfL0y7kXxWM81vMfW50bjDynARL9ITlNEZORAGFWjY+2CUIv/pnHHQZdSTh/AX2ThIz9ikOrgm4xdC6p3koT2OagC7RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r4sJ60jG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r4sJ60jG"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N0N2HC002916;
	Wed, 23 Oct 2024 12:53:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=gJjkoWx0v7EJieqmAwvTwDuoLvPP07
	4KFvWCYB8i+LU=; b=r4sJ60jGae15GMN6FQ6YWJJs2rKKoF279cH9jmuu5RwR5l
	y117AQ1ebruk1EUorF/4xKQ6sv4vM7uz2PBvP+NdjumT+kfuRqneV5yvFJlQqdD/
	ZveTO/XxD/mybfM07bHOcrbairbzzIy2ZLk775qqu47WzH7VBFIA/ZBWpklnjxxR
	C8Q4W3wwtJM4I2RByN3a2PkRxsXWl2HyWqNbzezKb8O8Lc6E7mk/IsXR8QaT6Aiz
	yE8wg4xQHMBaj+oE7lzavJ98rehlL2HvvKg7r1I2O/xVg8YZjTNJNs7WfEGMCoBI
	9wKHU2XNVktwVoPsPa+302x0PaKtePADjQUCBNiw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emafu13j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 12:53:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBRcPn014308;
	Wed, 23 Oct 2024 12:53:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emhfjvtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 12:53:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49NCrrOi57344388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 12:53:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D27820043;
	Wed, 23 Oct 2024 12:53:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A5AE20040;
	Wed, 23 Oct 2024 12:53:53 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Oct 2024 12:53:53 +0000 (GMT)
Date: Wed, 23 Oct 2024 14:53:51 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Alexander Egorenkov <egorenar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3] s390/kdump: make is_kdump_kernel() consistently
 return "true" in kdump environments only
Message-ID: <20241023125351.8013-I-hca@linux.ibm.com>
References: <20241023090651.1115507-1-david@redhat.com>
 <87ttd3t3v7.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
 <7da9f43f-e2a8-4079-8b1d-d7b16d8f388e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7da9f43f-e2a8-4079-8b1d-d7b16d8f388e@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AjL6nn8VDTpxcV38jjRBC9177R16lS95
X-Proofpoint-ORIG-GUID: AjL6nn8VDTpxcV38jjRBC9177R16lS95
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=924 phishscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230076

On Wed, Oct 23, 2024 at 02:22:18PM +0200, David Hildenbrand wrote:
> On 23.10.24 14:12, Alexander Egorenkov wrote:
> > Here is a typo in the condition, a redundant '!' before is_ipl_type_dump().
> > 
> 
> Thanks for catching these! Too much going back and forth ... :)
> 
> > Otherwise, looks very good to me.
> 
> Thanks for the fast review. I assume these can be fixed up when applying.
> But please let me know if a v3 is preferred, and I can send one after
> waiting a couple of days.

Fixed typos, slightly reworded subject and commit message, and applied.
Thanks a lot!
