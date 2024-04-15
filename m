Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6F77443E;
	Mon, 15 Apr 2024 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187738; cv=none; b=TiuGv6bArEPmj6DgIRMFGqFZ5jBEwLaTaGrBY8Md4g8BTvX27h0IL0aOCfxhHU/MyWhPIxv0jEgHeDA1aK0+f58mU+svmW6cosvnrHWU+XUtFfGD1hZqiuRlLwrurtIxU+7TaCX88w3hYD9ip39oNJCP918CMh4A83/i4uGzCdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187738; c=relaxed/simple;
	bh=gW5dJkONTtADcSzWSi8+D1cvrcM+lztYTM9P1lx6LCk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AZ7KKjCPNc2c2bSU3ZauEjyeFO5C0vzCxnu5z1q0G6/oYVfGF7ZzDsFCHbGWNcymU/snVod6xOfkCHHcuiN2d3Ur+xeF7s9cR8AwDg1FeFjDKkY4BBt6ldxDoistNlE0I7bePC2u5wzm2ZH2f7tvr0OmXvXENzg1NpkDhQpQ+Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NEMoiFhO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NEMoiFhO"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FD02kN004214;
	Mon, 15 Apr 2024 13:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gW5dJkONTtADcSzWSi8+D1cvrcM+lztYTM9P1lx6LCk=;
 b=NEMoiFhOKrje2Rt6ITVnRsFiEBRqo//FqVZpcwGkiN5eWhtBlyWuApEXioIG0bEHoZtd
 5jdPMt/afMW7dehfQMmOn2J/oDmub02o72kCEblopOYQGAdeRklev/ElBgo7o9N+b0w+
 WPCd4YRe3GZZpSZsIqdpwMfVUOLNIrJv7PN+cW089MFbbwYRfERw3Rb+Kkw3HFJNPoW4
 zFaQcskjf40t7Ms63Adt36CaVRlrvsclWJQDONPW44C40hnXO5fdtRlDUFB3zDzQZJB/
 OBX3CwkdRoZD8sED/CGzRn8R+uwrsNper9dS6Xj76WnvygP3Qb7iHKtkAszn7mXPyrwG /w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xh4r0r20k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 13:28:52 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43FDSqfg027926;
	Mon, 15 Apr 2024 13:28:52 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xh4r0r20f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 13:28:52 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43FAusYb011111;
	Mon, 15 Apr 2024 13:28:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg7327m32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 13:28:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43FDSkt951773786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 13:28:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2542220043;
	Mon, 15 Apr 2024 13:28:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5CB320040;
	Mon, 15 Apr 2024 13:28:45 +0000 (GMT)
Received: from [9.155.208.153] (unknown [9.155.208.153])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 13:28:45 +0000 (GMT)
Message-ID: <eed4aeb2566f5e9681ad2d24c6572eca5a8d037d.camel@linux.ibm.com>
Subject: Re: [PATCH net 1/1] s390/ism: fix receive message buffer allocation
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>, Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
        Wen Gu <guwen@linux.alibaba.com>, Heiko Carstens <hca@linux.ibm.com>,
        pasic@linux.ibm.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler
 <twinkler@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Date: Mon, 15 Apr 2024 15:28:41 +0200
In-Reply-To: <20240405143641.GA5865@lst.de>
References: <20240328154144.272275-1-gbayer@linux.ibm.com>
	 <20240328154144.272275-2-gbayer@linux.ibm.com>
	 <68ce59955f13751b3ced82cd557b069ed397085a.camel@redhat.com>
	 <cb7b036b4d3db02ab70d17ee83e6bc4f2df03171.camel@linux.ibm.com>
	 <20240405064919.GA3788@lst.de>
	 <50b6811dbb53b19385260f6b0dffa1534f8e341e.camel@linux.ibm.com>
	 <1e31497c3d655c237c106c97e8eaf6a72bcb562f.camel@linux.ibm.com>
	 <20240405143641.GA5865@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.4 (3.50.4-2.fc39app4) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cuj-LQzlz5lHsz3ZO6yueKHgD2fL2LkV
X-Proofpoint-ORIG-GUID: rgfTaLwGucmfQBHVxzM5oDdv_1wBZ0GS
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_10,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=704 mlxscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150086

On Fri, 2024-04-05 at 16:36 +0200, Christoph Hellwig wrote:
> On Fri, Apr 05, 2024 at 01:29:55PM +0200, Niklas Schnelle wrote:
> > Personally I'd go with a temporary variable here if only to make
> > the
> > lines a bit shorter and easier to read. I also think above is not
> > correct for allocation failure since folio_address() accesses
> > folio-
> > > page without first checking for NULL. So I'm guessing the NULL
> > > check
> > needs to move and be done on the temporary struct folio*.
>=20
> Yes, it needs a local variable to NULL check the folio_alloc return.
>=20

Hi, just a heads-up:

v2 that still missed this check got picked then dropped through the
netdev tree. Meanwhile I've sent new proper patch to this list of
recipients:

https://lore.kernel.org/all/20240415131507.156931-1-gbayer@linux.ibm.com/

Thanks,
Gerd
