Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1018E17FE
	for <linux-s390@vger.kernel.org>; Fri,  3 Jan 2025 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916053; cv=none; b=nNuB6E6bLG9geXE8d2ZXdfRrdiDf58PHQsOfk0C30IGWj4ldUadhcGqFCSFtfHN5NZMqUslTVMGt2cDvkmzntqJOBRzNH1eZVDN9OCvh3RERWsbpwWZ8kGNsB+uUzDRjVSIZTKNE/T/Y/hAIUItUe1XKVfn9tXg941Gtl82bngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916053; c=relaxed/simple;
	bh=7xj1O9Zj1G2y6As1+BorGoWTd2B7T+xSYolqqpUxV/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmTDN7dGZyj0Ym139J065XOncgwDY14D1ikz7WjhYkA9M3qDNq6PQ88u8Pn6zY6l9TSTYwxffJiyrcvw60O+n9ioIwZALxYM3tE0oUFtWuJzWOByRRKIlDVD35IjeY1/MgXuE0Ad+l0P650fzVGHGkQc/2xvqv1CDtpWKI99xg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UD2Rgxb+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UD2Rgxb+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502NbYT1027325;
	Fri, 3 Jan 2025 14:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v6le46
	ZsSyqQefHI7pvSyMiM9UIhpD9KW9UZqxjP2us=; b=UD2Rgxb+J6WxG0EjJf7kgJ
	nClyrNLvoxsRyajJ7jcZ1BGgA6G7OhaxwhRHI6LJxE6HJVXvqiloRCL4wRTfaCtg
	r68TJXbG+IUO2LDJpWvDgqEEAu6hheUZX40TO/hXKlK+HfG/eL9Y5e9qGoddKu+y
	UBtNBKRPB/fW085qVmy//wWi+i+PxJshjRsu0sMXEHjZT0MOY2LVyPuAClHJQPRb
	AJM6eaWYlRIBrgxz3sYNwFWC5PjNnycNwThIxYxZMYxmcPBxIIs14XFHp2UkwI8X
	CWgDRl/JtIPGjIVYWHDHmye78HMheeyupmhfGH4Ws03T4TQj+GoPbkH/TDhfxjuQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43x4maaptq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 14:54:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 503BN1oQ016656;
	Fri, 3 Jan 2025 14:54:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43tw5kpkbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 14:54:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 503ErxGj65864118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jan 2025 14:53:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96FC120043;
	Fri,  3 Jan 2025 14:53:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 445A12004B;
	Fri,  3 Jan 2025 14:53:59 +0000 (GMT)
Received: from p-imbrenda (unknown [9.171.61.205])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri,  3 Jan 2025 14:53:59 +0000 (GMT)
Date: Fri, 3 Jan 2025 15:53:56 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/2] s390: Remove uses of page->index
Message-ID: <20250103155356.01c50a59@p-imbrenda>
In-Reply-To: <20241219162252.1025317-1-willy@infradead.org>
References: <20241219162252.1025317-1-willy@infradead.org>
Organization: IBM
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qr-DhFhn_7fBi8QloRUo_Pd0D6RqA2xW
X-Proofpoint-ORIG-GUID: qr-DhFhn_7fBi8QloRUo_Pd0D6RqA2xW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=694
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030128

On Thu, 19 Dec 2024 16:22:48 +0000
"Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> These two patches compile ... I can promise nothing more than that.

hi,

I appreciate the effort, but I'm actually working on a series to
completely stop using page->index and page->lru . It works, only needs
reviews and some proper testing; I will send it out next week.

if David can send a polished version of his patch, I can pick it,
otherwise I'll polish the WIP he has already sent.

@David: can you please polish and resend your patch?

with that done, this whole series becomes moot (sorry)

> 
> David suggested to me that the gmap code really should be using ptdesc,
> and I think I agree with him.  The vsie code looks quite different
> and probably shouldn't be using a ptdesc, but we can use page->private
> instead of page->index.  It's not yet clear to me if we'll ever manage
> to get rid of page->private.
> 
> Matthew Wilcox (Oracle) (2):
>   s390: Convert gmap code to use ptdesc
>   s390: Convert vsie code to use page->private
> 
>  arch/s390/kvm/vsie.c |   6 +-
>  arch/s390/mm/gmap.c  | 181 +++++++++++++++++++++----------------------
>  2 files changed, 92 insertions(+), 95 deletions(-)
> 

