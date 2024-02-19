Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244EC3D553
	for <linux-s390@vger.kernel.org>; Mon, 19 Feb 2024 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359191; cv=none; b=HVqjZJko8vSFmmfceniWJ+25QkKsX9hNMSyPXxyD/xucQI6qm22Lvuor0x6kJi9KJJChDovtQOQc+/eIvLrnrXOVhXM0eYL/xPLWpKkz4EbrTGnwqJVVbBP2UpXscxQgWAfF1mctyvp0Wobcf4wr0nG9magqcSImnbpfvI5a/7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359191; c=relaxed/simple;
	bh=7Nmrqa5i0WoJAGRzW7TU2iew+3/VIT97/HZ3ocsJ+p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d0ORAjT4I4S4fbEv2NcSywpGcREzE0xwzrfVFh8IgmwFQ/YGUDFPZWEL1m2mbeZvSLJraYHdFkghw0/CXp3H4FmVCp/ms+yM8rrjPZE5PPAsMyTr1SwBMOgUDU114IxhGPTSgKPK6TeD9Ac/z5zmUSUiQ3M2n3w/kGJo+ZzX3rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I8/8SgWG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I8/8SgWG"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JFpJPZ021336;
	Mon, 19 Feb 2024 16:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=rlpyoIUk01foBzJz1UE0knNnkyCY1lyW/vxbv39q1L4=;
 b=I8/8SgWGrpiyP+e/RHG7ZngksLvsev8i0Kk1C8+8tw97JyG4uRRlD7IS9sGWqpiczvoC
 K0XZR3uBG5GRGxKNPxbr96YPh650qdolucI/2S74eFDmLNyYTHZeSIuVg4cfdrOk53bv
 QTdAChJfYpkA0VLKPrvQYSe9TWowDOt7JHxZ+ToOaGfPSLQ6/pUs9WktI4ykz0MDHN1C
 c17iok7Cr6mWQej4rJHTyuqVwhTitEQw4g2wGGyMbfAAjKlB7YaTwX7cIHLbiYZ0Sn1k
 cjphSD1ncITwzxlGba+7uYpmR5hBbpBR5kaVvEs519mVF1O8HvfC4UWcUgVrDtajTHza TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc99h9w0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 16:13:07 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JFpOFc021837;
	Mon, 19 Feb 2024 16:13:06 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc99h9w0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 16:13:06 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41JFbkTD031143;
	Mon, 19 Feb 2024 16:13:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9bkhtf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 16:13:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41JGD0YJ60096892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 16:13:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63C262004E;
	Mon, 19 Feb 2024 16:13:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE4CB2004F;
	Mon, 19 Feb 2024 16:12:59 +0000 (GMT)
Received: from osiris (unknown [9.171.27.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 19 Feb 2024 16:12:59 +0000 (GMT)
Date: Mon, 19 Feb 2024 17:12:58 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com,
        gor@linux.ibm.com, iii@linux.ibm.com, agordeev@linux.ibm.com
Subject: Re: [PATCH v2 0/4] s390: compile relocatable kernel with/without fPIE
Message-ID: <20240219161258.16287-E-hca@linux.ibm.com>
References: <20240219132734.22881-1-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219132734.22881-1-sumanthk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 74i96b_llBiKqGbHDkPYi-NDdKWjdQ0p
X-Proofpoint-ORIG-GUID: fE4n4lnMfCx0eOGhlwIR5isbRQGSu6Ii
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_12,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=574
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190121

On Mon, Feb 19, 2024 at 02:27:30PM +0100, Sumanth Korikkar wrote:
> Hi All,
> 
> This is a rebased version of Josh's patch series with a few fixups.
> https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=s390
> 
> This introduces the capability to compile the s390 relocatable kernel
> with and without the -fPIE option.
...
> Josh Poimboeuf (2):
>   s390: Add relocs tool
>   s390: Compile relocatable kernel without -fPIE
> 
> Sumanth Korikkar (2):
>   s390/vdso64: filter out munaligned-symbols flag for vdso
>   s390/kernel: vmlinux.lds.S: handle orphan .rela sections
> 
>  arch/s390/Kconfig                    |  15 +-
>  arch/s390/Makefile                   |   8 +-
>  arch/s390/boot/.gitignore            |   1 +
>  arch/s390/boot/Makefile              |  14 +-
>  arch/s390/boot/boot.h                |   6 +
>  arch/s390/boot/startup.c             |  80 +++++-
>  arch/s390/boot/vmlinux.lds.S         |  18 ++
>  arch/s390/include/asm/physmem_info.h |   1 +
>  arch/s390/kernel/vdso64/Makefile     |   1 +
>  arch/s390/kernel/vmlinux.lds.S       |  15 ++
>  arch/s390/tools/.gitignore           |   1 +
>  arch/s390/tools/Makefile             |   5 +
>  arch/s390/tools/relocs.c             | 390 +++++++++++++++++++++++++++
>  13 files changed, 542 insertions(+), 13 deletions(-)
>  create mode 100644 arch/s390/tools/relocs.c

Thanks a lot for providing this!

Series applied.
