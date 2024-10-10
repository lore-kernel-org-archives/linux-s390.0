Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84901D318A;
	Thu, 10 Oct 2024 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571274; cv=none; b=clGsCr8+QByIXFl7bkhxkhxxWXPqBb+iDNWjXpteykJwGB1QNIJ1fN+vqx6fb+zEY0Lse2er3CEdmxg6pEtgUTRpD0KGVOufptZuvd4K+19PSeJR4WJOQlmhyijqZSOG2yRuYd1+ZlZCvKhYNCdIZtyUkM/elt5YlswgRx4znk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571274; c=relaxed/simple;
	bh=lz71XzaNG0yVrDt1WTunslV5rf5BbFvnhf2NJVOJ3ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvGSSPy5z9K8VlYXnXWCajfomBwITrMGa6jhqd4DCkaeG5vvrArsB1OMm+xlbExM2hqQrCrT2Ax1QnbRBusb5X/1ACVCDCPLWEKtI+GV+ahXE8R581vJkT4Kem3uMHGHGIvFLGM9druVkcFoWm2I9gOoMMhnOipLey/Sm6ZB8zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oMM+hHbx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oMM+hHbx"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ADKFFj031559;
	Thu, 10 Oct 2024 14:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=KJ7obiUQsc0gi7rSB7YbRqDTUNO
	qFh295ecCfP3r4I8=; b=oMM+hHbxJFu0iKt3zidRaax35B+5x8abmMvcNFO+Krh
	I8lKdN9A51Y4+ki5aCJg3tgn6U5h8e+fU4OqO1J4W9hNX31R725fxL2Rsj2+aBm5
	l+5g2suew6UiCHmqxgVjPWPKuVOgxBoTsXqfcl9VjQZkUyEQkgzS1AWo63c8hru2
	QI1sBnOd93B6kb61ffyHeFh1yF9HQh8+SZWGF4LJ3dWPxZ1EZQ3YSZ4qap7sIf5r
	pVvOccAm6SxBx41nBCZhNtnRHsDJQzRmETlX8J0vi/9Qt2uEJ2WOmfu/7TAlLvgQ
	jYIefjS30z6jbVLg2bOrLHqcdAZN1THeYdwFoRMJSag==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 426fqk8er7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 14:41:07 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49AEbb81000832;
	Thu, 10 Oct 2024 14:41:07 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 426fqk8eqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 14:41:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49AE1d5O022867;
	Thu, 10 Oct 2024 14:41:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg17yug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 14:41:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49AEf3nj20906356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 14:41:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 003EE2004B;
	Thu, 10 Oct 2024 14:41:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD11620040;
	Thu, 10 Oct 2024 14:41:02 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 10 Oct 2024 14:41:02 +0000 (GMT)
Date: Thu, 10 Oct 2024 16:41:01 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Mario Casquero <mcasquer@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        virtualization@lists.linux.dev, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 0/5] virtio-mem: s390x support
Message-ID: <20241010144101.15346-C-hca@linux.ibm.com>
References: <20240910191541.2179655-1-david@redhat.com>
 <CAMXpfWvRy_fpNUXeVO_-0O9WXDYY8f+cBEQQvsqZD2g2043LaA@mail.gmail.com>
 <e0e13b95-bc9a-4f4b-a721-379676725525@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0e13b95-bc9a-4f4b-a721-379676725525@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EE3Dkc8rCcd301tXUOjUXD5mTbEF83eP
X-Proofpoint-ORIG-GUID: tuVe5hxUbXesJKRGXR5xf0cDEAn-KsaD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_11,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 clxscore=1011 adultscore=0 mlxlogscore=713 bulkscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410100097

On Thu, Oct 10, 2024 at 02:31:31PM +0200, David Hildenbrand wrote:
> On 10.10.24 10:41, Mario Casquero wrote:
> > This series has been successfully tested along with the QEMU's series.
> > Virtio-mem devices could be resized, plugged and unplugged seamlessly.
> > The memory information displayed is correct and reboot doesn't cause
> > any issue.
> > 
> > Tested-by: Mario Casquero <mcasquer@redhat.com>
> 
> Thanks a bunch for testing!
> 
> If there are no more comments, I'll add the in-tree kernel update for the
> new diag500 subcall and resend.

Sorry that you haven't seen any review from here yet, but... :)

Please also change all usages of "s390x" to "s390" before you resend.
Within the kernel usage of s390x is not common and there shouldn't be
anything like this added.
