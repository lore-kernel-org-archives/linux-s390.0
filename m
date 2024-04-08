Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CFFF51B;
	Mon,  8 Apr 2024 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712603176; cv=none; b=CD4Du/sMHlcOMIJQpuGfoN1tHBIuTFCvV5YmYD+ZW+LCPBVEXh+bsYUXJibxSWivFxUkWvKRT/pgX7KbT2z/XR5YNOTNMvudBk1hm8gSqK+I6yTBUa8zQw/uM/pUA094+lqQUoyzychCrbzXIEULCoYcPF8ilY15zH4kHp3C4mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712603176; c=relaxed/simple;
	bh=vjOCP4OiBVZzjLbSPcM9Y1By12q63aZiclbN49HLSMA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QEMr4ux6wgq4d/mBOtRpFVTndjMH20W+yot2Ox84qR7XeXxT2tpnYvGbrw6EsVeVCqYw63csZ32FdAxokdmEffGEyg4dTx53QXF9/FxV8T8xprsxCVS3fK3KkRnN0r2x6888S/oQfE+anxRjsQ+4Cpj9b68DwUe8giYk1Omce5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K1b7djLm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K1b7djLm"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438I78ck026339;
	Mon, 8 Apr 2024 19:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vjOCP4OiBVZzjLbSPcM9Y1By12q63aZiclbN49HLSMA=;
 b=K1b7djLms1a2e63qbHztU7s/pHJLBb/0D1T8koIJSgH0kpLzft0VZe3b060b19jW7kkk
 ecW1Cz00qEPfMle51vUT+KGxRxrtg2vKxsBg2F1Hpwc63Hmpauq93kfByJXwYwarApgP
 SPu6dDm4Z76kecstECkZb2XBq79K8TfbyKKbauSOtbOODHtyZPA4j5kwzcOkmDvcmeWx
 Gs89gXv2ZP7+/OHcMHU+nabERzF7+BEstKESf1PK9X7OrSvM/PG7R9tY2nd97N1oIeex
 cx4+4OnYMI0duC4MCORMOlgB5MdJ2c6Y6qaErrXTWsR2aKeCkI9z7cHvuhJujB6KAvq0 Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xcnjvg39t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 19:06:08 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 438J68A8026207;
	Mon, 8 Apr 2024 19:06:08 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xcnjvg39e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 19:06:08 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 438IUCeg029940;
	Mon, 8 Apr 2024 19:05:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbj7m1puj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 19:05:54 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 438J5mng17039748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Apr 2024 19:05:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBDDB2004D;
	Mon,  8 Apr 2024 19:05:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12BC02004B;
	Mon,  8 Apr 2024 19:05:48 +0000 (GMT)
Received: from [9.171.3.244] (unknown [9.171.3.244])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Apr 2024 19:05:47 +0000 (GMT)
Message-ID: <7e6baff2338ef4c3af9073c46b5492f271bdd9ae.camel@linux.ibm.com>
Subject: Re: [PATCH net v2] s390/ism: fix receive message buffer allocation
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        "David S.Miller"
	 <davem@davemloft.net>
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, hca@linux.ibm.com,
        pabeni@redhat.com, hch@lst.de, pasic@linux.ibm.com,
        wenjia@linux.ibm.com, guwen@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com
Date: Mon, 08 Apr 2024 21:05:47 +0200
In-Reply-To: <87cfb39893b0e38164e8f3014089c2bb5a79d63f.camel@linux.ibm.com>
References: <20240405111606.1785928-1-gbayer@linux.ibm.com>
	 <171257402789.26748.7616466981510318816.git-patchwork-notify@kernel.org>
	 <87cfb39893b0e38164e8f3014089c2bb5a79d63f.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.4 (3.50.4-2.fc39app4) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3D7BVhtmeeMfVdps4NeeGOz9Mpa3Zf6W
X-Proofpoint-GUID: 09ObFrvA-3gjMQjg7iH4Mel5IB8PP06S
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
 definitions=2024-04-08_16,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 mlxlogscore=951 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404080148

On Mon, 2024-04-08 at 14:40 +0200, Niklas Schnelle wrote:
> On Mon, 2024-04-08 at 11:00 +0000, patchwork-bot+netdevbpf@kernel.org
> wrote:
> > Hello:
> >=20
> > This patch was applied to netdev/net.git (main)
> > by David S. Miller <davem@davemloft.net>:
> >=20
> > On Fri,=C2=A0 5 Apr 2024 13:16:06 +0200 you wrote:
> > > Since [1], dma_alloc_coherent() does not accept requests for
> > > GFP_COMP
> > > anymore, even on archs that may be able to fulfill this.
> > > Functionality that
> > > relied on the receive buffer being a compound page broke at that
> > > point:
> > > The SMC-D protocol, that utilizes the ism device driver, passes
> > > receive
> > > buffers to the splice processor in a struct splice_pipe_desc with
> > > a
> > > single entry list of struct pages. As the buffer is no longer a
> > > compound
> > > page, the splice processor now rejects requests to handle more
> > > than a
> > > page worth of data.
> > >=20
> > > [...]
> >=20
> > Here is the summary with links:
> > =C2=A0 - [net,v2] s390/ism: fix receive message buffer allocation
> > =C2=A0=C2=A0=C2=A0 https://git.kernel.org/netdev/net/c/58effa347653
> >=20
> > You are awesome, thank you!
>=20
> This version of the patch has an outstanding issue around handling
> allocation failure see the comments on v1 here[0]. Please drop. Gerd
> will send a v3 with that issue fixed.
>=20
> Thanks,
> Niklas
>=20
> [0] https://lore.kernel.org/all/20240405143641.GA5865@lst.de/

Hi Dave,

so how do we go forward? Would you revert this v2 in the netdev tree to
have my next v3 properly reviewed?

Second best option: I can send a fixup to address the last issue from
[0], but that would still leave some pieces sent with (v1/v2) not
properly R-by'd or at least ack'd.

Thanks,
Gerd
