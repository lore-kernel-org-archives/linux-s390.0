Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B7129A2;
	Wed, 29 Jan 2025 20:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738183124; cv=none; b=kiyS/+8w6QH//+MzHqdx5E5dn93pMycjRyJtblnsZdUd+pKG5aXzGKXEMg/ILJw8IMAGSUE+KGOWgmJ44MhqYg6U4EvlzxMVbHLxohs1XLBgNOtDy/USPP1myCV5TKVxHOlhzW87loChh+mX0GFSKcN2/VJLSuUg9NZoLS1g+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738183124; c=relaxed/simple;
	bh=u7bkkFbgFIRXyXjanPwlyDibiv2H8vlJ8rkMU2DVKcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZv6iD/1fsubL8agu6OlLPDV0sorZ+j34VN8U3hKFNqbfcR3f6quWinQX0UwpPAXf49nTXOHGVlSI9mJW4/Rx5lbweER8CvvAU9i2eHPMCqoVBll/dp6XGrDcigKkbrNPJqea+OaCJEJ/DnreCDCNfTeBoA3+l6QLWm08vRfFE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eByBx+rM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eByBx+rM"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TDdeOY004395;
	Wed, 29 Jan 2025 20:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1paovO
	MNVQAoBPhr5hxiZ1wYuOUpazAMiY0kx/X16Qo=; b=eByBx+rMlUWkC4obFL5Ivy
	WI6nfiJgzGeZNMYIxH9HOZ8biofCgor5zEB3txawrQ9hSKz+kmfuzgPSEYAF4CPO
	R0bAM91iXMje9usONAac0kLZ2J4ct37GKQwLmXlVorMhQoP+GJT5mNTERWaepnn7
	gdQi5iYL86VwMmptIYwa/GQLPRyIhBta0dVdF/noWE83x9ulbRdT+n0Ow/hlqDVY
	nbbMbP9Wz1RdebgmJEBS8r26CDi4cwboXGKf+oLUcg12RqBiq76xRp8L55Rqfjky
	7guFpJy6gfI8oVlKbz8CmFbmBlzTbJE+X6m8S/7u5Uvgu2/jFoslCfEUgU34cR9g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fad9n39k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 20:38:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50THjpRf022175;
	Wed, 29 Jan 2025 20:38:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dcgjtcgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 20:38:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50TKcTTS53215676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 20:38:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A991200A4;
	Wed, 29 Jan 2025 20:38:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81C50200A3;
	Wed, 29 Jan 2025 20:38:28 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.179.12.122])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 29 Jan 2025 20:38:28 +0000 (GMT)
Date: Wed, 29 Jan 2025 21:38:26 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne
 <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-hardening@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] s390/vfio-ap: Replace one-element array with flexible
 array member
Message-ID: <20250129213826.291cfe12.pasic@linux.ibm.com>
In-Reply-To: <20250116131859.105756-2-thorsten.blum@linux.dev>
References: <20250116131859.105756-2-thorsten.blum@linux.dev>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fBgppfXwsLTHHsfj8173ivdA6KbuCFqH
X-Proofpoint-ORIG-GUID: fBgppfXwsLTHHsfj8173ivdA6KbuCFqH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_04,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=875 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290157

On Thu, 16 Jan 2025 14:18:59 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> Replace the deprecated one-element array with a modern flexible array
> member in the struct ap_matrix_dev.
> 

I'm not sure I understand the value of this. What we have here is not
a flexible array but a one element array. Something that in the generic
case could be many but particularly for vfio-ap is always one.

Imagine if we had exactly 2 supported mdev types. I guess you would not
come to the idea that the array of two needs to be changed to a modern
flexible array. Or am I wrong about that?

So I suppose the problem  here is that arrays of one are under general
suspicion of not actually being arrays of one but a pre C99 way of
doing flexible arrays. I kind of do understand that an array wih
one element is funny. But I think the current declaration of
struct ap_matrix_dev is more expressive the proposed one.

Now I understand that it is easy to grep for [1], but it is much
harder to tell.

I've checked in Documentation/process/coding-style.rst did not see this
documented. But then I checked in checkpatch.pl and it indeed seems to
warn about it and refer to
https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays

But as far as I can tell it is also talking about the case where one
needs a trailing array of an at compile time unknown size, and not
about the case where all we need is just one element and it happens
to be convenient to have it in an array.

If there is community consensus that one sized arrays are bad regardless
of what they are used for, then the one sized array has to go.

But please tell me what speaks against replacing it with a single
pointer and then taking passing in that pointers address into
mdev_register_parent()?


> Use struct_size() to calculate the number of bytes to allocate for
> matrix_dev with a single mdev_type.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

