Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2F6140396;
	Thu, 11 Apr 2024 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826853; cv=none; b=HEG/3be5BbVdfvQlyDS+4qm9XnaHAMT9VIwYeB0zxRz52vFqdMM8O59wVBts+qf7/pT1ncIii5C0XrhwG3Vc8SM8G4fHDHBMrhycyCJ+6X3HVYFspqF80LV8Qm0XYs6JkuA1DJmhT3Jy0ENdMoq1FoNjgEuxjmZPE6a9p2O5gYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826853; c=relaxed/simple;
	bh=Fcu3SvfG7idtKalMhr0vRQ6Y7onjhyyIlZchn+ArnvI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L/chtOeOMs3KjTE6kDaWU7lWDbyHzV61wcF11pwx3ubg7dhsdS/ctBb6huxZuSpwRL6hXRTbiaSa/p3to8Zqh5+DQbCKdV4cxjQBoQ2VY/VCvxf+AH+ss62Klo8qCUw0QbOmAJ6K0PWsZTszQ3nt4Oymaj+hdvR4i7BDJHH+YPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JqHdBxVz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JqHdBxVz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43B82eOP032404;
	Thu, 11 Apr 2024 09:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Fcu3SvfG7idtKalMhr0vRQ6Y7onjhyyIlZchn+ArnvI=;
 b=JqHdBxVzKpjrABJsRq3gEBF/uuolMahcNKbnbpsEWB5KLnb5CKUd+byPd8Um+tRKmYdV
 6/Y73NtszAGF9qorSYZBJ789lVaij+rz2pOq9cFGHQIEhbEkkoKHZDdwpaLlVLtbkHiS
 Nm0it0DWTri1f4b0THzKt1Wf6/gX4ZLBkIZJJEeHkvLk6l86sE8HtgAYXYz7s0HKlc1u
 Qz0Behw717A4LHKrnbbs7qE7OdcQ0B+UMHyKrDupPzPvVaZDSwov50v4gcqbD+eRGn4+
 s6v0SUrC6DnsPWQbZS16N7pT34LAQfMo7e6KKvgf4ErYWeG7yMs1V7Gb/hcEwFTivdbD iA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xec0hg5cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 09:14:01 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43B9DrK1005866;
	Thu, 11 Apr 2024 09:14:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xec0hg5c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 09:14:01 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43B8YYwB019108;
	Thu, 11 Apr 2024 09:14:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbh40jf2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 09:14:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43B9DsDc54526304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 09:13:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C0F32004B;
	Thu, 11 Apr 2024 09:13:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF48D20043;
	Thu, 11 Apr 2024 09:13:53 +0000 (GMT)
Received: from [9.171.74.197] (unknown [9.171.74.197])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Apr 2024 09:13:53 +0000 (GMT)
Message-ID: <60455a55f6595b9ac0fe8922a162b5727556d85a.camel@linux.ibm.com>
Subject: Re: [PATCH net] Revert "s390/ism: fix receive message buffer
 allocation"
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Paolo Abeni <pabeni@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
        Christoph Hellwig
	 <hch@lst.de>, Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller"
	 <davem@davemloft.net>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Alexandra Winter
 <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>, pasic@linux.ibm.com,
        schnelle@linux.ibm.com
Date: Thu, 11 Apr 2024 11:13:53 +0200
In-Reply-To: <facf085f326813ec12566b3458650746e0267aca.camel@redhat.com>
References: <20240409113753.2181368-1-gbayer@linux.ibm.com>
	 <facf085f326813ec12566b3458650746e0267aca.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-2.fc39app4) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MZGELUC8CYGF8UPhGzRpCQuo9XMaFMgN
X-Proofpoint-ORIG-GUID: RHswPLLcPovRa8-hRjZaeTETyqYP_MT4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_03,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=842 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404110065

On Thu, 2024-04-11 at 09:16 +0200, Paolo Abeni wrote:
> Hi,
>=20
> On Tue, 2024-04-09 at 13:37 +0200, Gerd Bayer wrote:
> > This reverts commit 58effa3476536215530c9ec4910ffc981613b413.
> > Review was not finished on this patch. So it's not ready for
> > upstreaming.
> >=20
> > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
>=20
> It's not a big deal (no need to repost), but should the need arise
> again in the future it would be better explicitly marking the
> reverted commit in the tag area as 'Fixes'. The full hash in the
> commit message will likely save the day to stable teams, but better
> safe then sorry!

Thanks Paolo for the explanation. I was not even sure if the commit
hash of the erroneous commit will remain stable when this tree will be
merged upstream. In my (naive?) view this could be "autosquashed" into
nothing at the time of the merge.

But since there appears to be time for the next pull request to
upstream, I'll send a new version of the original patch with all the
review comments addressed.

Thanks again,
Gerd
