Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD2717A583;
	Thu, 14 Nov 2024 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603940; cv=none; b=DJYBb6sAm+/dKQJbtAyI/F5P55GLOFernhLD1fQn8Tq8DLhVs4AMEOkj/xc+hfe4h3lnyII4g6fhFXrt2uZzoM21mFGQTE8kaYuViwIu38A+aXpEXacc06RiN2APBultfwqdCilZuA4JdbbIGXF/PAKe9mnff0Nm9cr1VawXwe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603940; c=relaxed/simple;
	bh=ctPoNpyw7B43EpjYtu1D0VUr/leVJ/e9BGLGzOpgfgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXssa07lrt5aWDRwY1rnVLVH73iALOkWquh1WnXaQMcp8VciapBOvoEvCYKVgxhH0b6z3QbCg+donWveuMsYp1IojVTMlCmk9qfWg2JrWIegS2MTlAEIoheVt6Xi7Us+0z+PnaI4jKUk0EFhLyKdhKCykTnP/cgrZ+Xt8kt7aqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jtm/oE6g; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jtm/oE6g"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEEYAb2023146;
	Thu, 14 Nov 2024 17:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6+92PXTF+gXZGwldiZZaVYo8t2wuCz
	JwE4PduF5x00s=; b=Jtm/oE6gHXuFsv2n4lqmnCWCCbVtHt9AkfuDVhxkuuR3R5
	NzUusr5MHGax3qBebfleGm7/dBiYpZjWZFoXg4UOYtvhFuUAXokDNgdsNMDyJRlk
	tacMR8tQ4S4jZGLAgyNiG9hI+QsrNMBTIhDZrTxVrDyvI13jUpgQ54XB+/IPjQf4
	JGyYW0q1BWlel8IwJZiZ0/8+EpRjuF4JGEBLH2kurrGg8ZnxND1NhmV2OLVWqQnn
	9fAYWdZo5TJOISLIBDnBla34mmc5eTHmx2qtAEbgFowbZTKM9jcBk0S6hLYTZ2M2
	EJNIYTzuM2CuDCqAjI+r1w3Z6iDoY0V8eyZVe4bQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wbpy3f9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 17:05:32 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AEH5WiD027051;
	Thu, 14 Nov 2024 17:05:32 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wbpy3f9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 17:05:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEGwVdg029724;
	Thu, 14 Nov 2024 17:05:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tkjmh9cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 17:05:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AEH5RWP51118438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:05:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66F852004F;
	Thu, 14 Nov 2024 17:05:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 280222004B;
	Thu, 14 Nov 2024 17:05:27 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 14 Nov 2024 17:05:27 +0000 (GMT)
Date: Thu, 14 Nov 2024 18:05:24 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 1/2] scripts/min-tool-version.sh: Raise minimum clang
 version to 19.1.0 for s390
Message-ID: <20241114170524.9691-B-hca@linux.ibm.com>
References: <20241113154013.961113-1-hca@linux.ibm.com>
 <20241113154013.961113-2-hca@linux.ibm.com>
 <20241113182109.GA3713382@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113182109.GA3713382@thelio-3990X>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8gWOEOYx9caPAiOROaJkvzRkS85Lu8o-
X-Proofpoint-ORIG-GUID: MzU9ZWfp2nRQb-IMHh5BLljHuYCpvxAK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=492
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140134

On Wed, Nov 13, 2024 at 11:21:09AM -0700, Nathan Chancellor wrote:
> On Wed, Nov 13, 2024 at 04:40:12PM +0100, Heiko Carstens wrote:
> > Raise minimum clang version to 19.1.0 for s390 so that various inline
> > assembly format flags can be used. The missing format flags were
> > implemented with llvm-project commit 9c75a981554d ("[SystemZ] Implement A,
> > O and R inline assembly format flags (#80685)").
> > 
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> 
> Oof, this is quite new but now that kernel.org has LLVM binaries
> available, I do not think this is an unreasonable ask, especially if it
> makes your life easier with code maintenance.

Thanks for your feedback! I read this as "is nearly unreasonable" :)

Even though you acked this, I guess I will drop this for now and
maybe address this a few clang versions later.
