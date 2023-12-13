Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="owP7qQuS"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794249A;
	Wed, 13 Dec 2023 04:17:55 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDBq4nw026207;
	Wed, 13 Dec 2023 12:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2LO+KZOc1A6iY+w5EuG6nKQ43T54kE83JDUPE8JPgPs=;
 b=owP7qQuS6C3ZQ9Op3YDzPTHUPWDFok2QrxFkyATpCL8bJfLRCzxNK9+qIMB4yhzzXu6b
 WfWuTDpoOqFDKXRO2aq+L7j4yTv1hZRtZ2GO7zo0U084XduncbnB5WKqhypRb9NKCvgG
 q5OBvARW85wtcUIiKnaHHXVnljbSENniGftfyO1W7a3vowTOF8JaEgA0QMpm3Q2MWD3i
 XGO90qOFrjqkBJ7NPuH0bjmllUOSP8Nxw8my4gC5/j6IqaROfC2Ny5ewFJykdTJV6yED
 aWiku1XvPYpS1rFfc4J68zz3iHOHqFOEpHCN3djXCD9o0YjKU/r14yk025ZbU0cJlA7O xA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyc450sav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 12:17:52 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDCBglT025077;
	Wed, 13 Dec 2023 12:17:52 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyc450saf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 12:17:52 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDAcktX004101;
	Wed, 13 Dec 2023 12:17:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4skg8u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 12:17:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BDCHmrt12321508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 12:17:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4578B20043;
	Wed, 13 Dec 2023 12:17:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00F0F20040;
	Wed, 13 Dec 2023 12:17:48 +0000 (GMT)
Received: from [9.152.224.39] (unknown [9.152.224.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Dec 2023 12:17:47 +0000 (GMT)
Message-ID: <2c460a84c6e725187dda05fc553981ce3022bb78.camel@linux.ibm.com>
Subject: Re: SMC-R throughput drops for specific message sizes
From: Gerd Bayer <gbayer@linux.ibm.com>
To: "Nikolaou Alexandros (SO/PAF1-Mb)" <Alexandros.Nikolaou@de.bosch.com>,
        "D . Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
        Nils Hoppmann <niho@linux.ibm.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        netdev
	 <netdev@vger.kernel.org>, Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher
	 <jaka@linux.ibm.com>
Date: Wed, 13 Dec 2023 13:17:47 +0100
In-Reply-To: <PAWPR10MB7270731C91544AEF25E0A33CC084A@PAWPR10MB7270.EURPRD10.PROD.OUTLOOK.COM>
References: 
	  <PAWPR10MB72701758A24DD8DF8063BEE6C081A@PAWPR10MB7270.EURPRD10.PROD.OUTLOOK.COM>
	 <ccc03f00-02ee-4af6-8e57-b6de3bc019be@linux.ibm.com>
	 <PAWPR10MB7270731C91544AEF25E0A33CC084A@PAWPR10MB7270.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3qJCnWvMKx-zjMUMBWbfO7VTeUTOmrRr
X-Proofpoint-GUID: IULt2Ub6WF76JU1Zjf2vBZPIIpuOjyT0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_05,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130089

Hi Nikolaou,

thank you for providing more details about your setup.

On Wed, 2023-12-06 at 15:28 +0000, Nikolaou Alexandros (SO/PAF1-Mb)
wrote:
> Dear Wenjia,=C2=A0

while Wenjia is out, I'm writing primarily to getting some more folks'
attention to this topic. Furthermore, I'm moving the discussion to the
netdev mailing list where SMC discussions usually take place.

> Thanks for getting back to me. Some further details on the
> experiments are:=C2=A0
> =C2=A0
> - The tests had been conducted on a one-to-one connection between two
> Mellanox-powered (mlx5, ConnectX-5) PCs.
> - Attached you may find the client log of the qperf=C2=A0output. You may
> notice that for the majority of=C2=A0message size values, the bandwidth i=
s
> around 3.2GB/s=C2=A0which matches the maximum throughput of the
> mellanox=C2=A0NICs.=20
> According to a periodic regular pattern though, with the first=20
> occurring=C2=A0at a message size of 473616 =E2=80=93 522192 (with a step =
of
> 12144kB),=C2=A0the 3.2GB/s throughput drops substantially. The
> corresponding commands for these drops are =C2=A0
> server: smc_run=C2=A0qperf=C2=A0=C2=A0
> client:=C2=A0smc_run=C2=A0qperf=C2=A0-v -uu=C2=A0-H worker1 -m 473616 tcp=
_bw=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> - Our smc=C2=A0version (3E92E1460DA96BE2B2DDC2F, smc-tools-1.2.2) does no=
t
> provide us with the smcr=C2=A0info, smc_rnics=C2=A0-a=C2=A0and smcr=C2=A0=
-d
> stats=C2=A0commands. As an alternative, you may also find attached the
> output of ibv_devinfo=C2=A0-v.=C2=A0
> - Buffer size:=C2=A0
> sudo=C2=A0sysctl=C2=A0-w net.ipv4.tcp_rmem=3D"4096 1048576 6291456" =C2=
=A0
> sudo=C2=A0sysctl=C2=A0-w net.ipv4.tcp_wmem=3D"4096 1048576 6291456"=C2=A0
> - MTU size: 9000=C2=A0
> =C2=A0
> Should you require further information, please let me know.=C2=A0

Wenjia and I belong to a group of Linux on Z developers that maintains
the SMC protocol on s390 mainframe systems. Nils Hoppmann is our expert
for performance and might be able to shed some light on his experiences
with throughput drops for particular SMC message sizes. Our experience
is heavily biased towards IBM Z systems, though - with their distinct
cache and PCI root-complex hardware designs.

Over the last few years there's a group around D. Wythe, Wen Gu and
Tony Lu who adopted and extended the SMC protocol for use-cases on x86
architectures. I address them here explicitly, soliciting feedback on
their experiences.

All in all there are several moving parts involved here, that could
play a role:
- firmware level of your Mellanox/NVidia NICs,
- platform specific hardware designs re. cache and root-complexes,
interrupt distribution, ...
- exact code level of the device drivers and the SMC protocol

This is just a heads-up, that there may be requests to try things with
newer code levels ;)

Thank you,
Gerd

--
Gerd Bayer
Linux on IBM Z Development - IBM Germany R&D
