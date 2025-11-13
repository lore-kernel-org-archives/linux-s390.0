Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216BB31AF3E;
	Thu, 13 Nov 2025 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063140; cv=none; b=WhEDxyEsvET23xVbdEAGdweFBB5NLJoz1vv/Rhje9Llscb0pHMlxAWTKaeFBB+jrHcTZqw9rbJuhlF2wilaQmSMT9CtU0NnNXRrU6QIjfwCaYF44hucCgr1y3Lf/Dz0DPwVFLsmR/3BuC5jKHDImmjXcScIXJqlFTkBDrS6KNwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063140; c=relaxed/simple;
	bh=nax9ZHenbsP3cifQ+6Nop6vw8o3sZ/B5k/1/IQBzfqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiwHir0/+jYfgBMpmyKYLK72BKAxN+nSIPfujZv2cy7/Uzp1O//Ymu+z2FcIiNNhMPYDwGawXeI1gzmcjLNjxtoyPf6mA0Pxe2B9ZGPLqiB865ZbLjcx2MgYTM4pYaomxNo6hWiXUCyHaYvlQfzd0Vcir19Z8IBx1P1p+K+L8M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qbi3lwx0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qbi3lwx0"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADIdl3J022003;
	Thu, 13 Nov 2025 19:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sYFWWS
	ybzvahKVs9BGfDUWCxrSwc2SuxAPmR1tiery8=; b=qbi3lwx01vBz4zAmoMw0a9
	R6P+OBCWg48RITLGtCC/4F0vYaxlh6ZuWPfLzZIPHMOysxM9JxOS/8ajjHAyl8Ia
	MkFRiH9iUArjlrtpJJSIrO+D9TjFIY6s2sjTBUmQgiUlQYGZ1PQkiBYxIi945lo6
	TkdK67IyftCyrsijcB7kEb1AALVQXvK5uUpwSXFrh6DW8ACvdE7D74BKlwcYOKRu
	z6k+6R/rewMZFsCcbSbpInNIJTzEL817u4zVlxAyOElPSphw/UOmoKL9aAOjw6YI
	+wvB/5ocOmv26injxeH+WSDjmRoMIgW8D068gFEObOy70NIJRUUEkkC8I7Ae0k0g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tk76x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 19:45:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADJ8rQ5028880;
	Thu, 13 Nov 2025 19:45:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6sqwxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 19:45:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADJj7i959769120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 19:45:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF0CE20049;
	Thu, 13 Nov 2025 19:45:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3145D20040;
	Thu, 13 Nov 2025 19:45:07 +0000 (GMT)
Received: from osiris (unknown [9.111.38.203])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 13 Nov 2025 19:45:07 +0000 (GMT)
Date: Thu, 13 Nov 2025 20:45:05 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Willy Tarreau <w@1wt.eu>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/8] tools: Remove s390 compat support
Message-ID: <20251113194505.7746Bc8-hca@linux.ibm.com>
References: <20251113150731.2697279-1-hca@linux.ibm.com>
 <20251113150731.2697279-5-hca@linux.ibm.com>
 <72a8ffff-5074-4a7f-94ee-454c21f8a130@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72a8ffff-5074-4a7f-94ee-454c21f8a130@t-8ch.de>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YpAoW1u82zZkTULMYz7ruOCbpFugtg3E
X-Proofpoint-ORIG-GUID: YpAoW1u82zZkTULMYz7ruOCbpFugtg3E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfXxP1x5n/WzggD
 0P4QlpS0x1pjPbGkTzrBIVosg12AgL346rp61hSUnuNFe/DHvgPjPK5YrlBVt9u8gZtfZjoOC/l
 1wg887PNcCiGfO5T7NDJ+vLxY2145WaZDmfNK3Op7vIJCgsinkNMBi82YWzaLfPhTVjbJJixbh8
 G4vmuw1XOriTWZeK6nz3M1krlJKOWtb6vO1kTA9SSQ6ryi07xDEGbb4UXpd3V3vo10+JosFK1ZG
 UJPLcFK/4CeGiiPL+/Qii44GmbJBq3XKpgNHXyVf9BYPofQC0o5XYs0ISZJQnpFsLSg1wX1lCZ8
 gdD0c68sOOijNQeij2nCPZRIIebTvLgZLpYx+1a2i1SmHSxSBTosF6c7Q7MN8j/FlD8qqnMRPMU
 hudBz9ym9ETIdQ4sDZz5RSpen9CKTA==
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=69163548 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=8RV-Oewd9zCQFDWjh_IA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080099

On Thu, Nov 13, 2025 at 04:43:59PM +0100, Thomas Weißschuh wrote:
> On 2025-11-13 16:07:26+0100, Heiko Carstens wrote:
> > Remove s390 compat support from everything within tools, since s390 compat
> > support will be removed from the kernel.
> > 
> > While removing s390 compat code replace __s390__ ifdef guards with
> > __s390x__ everywhere. Even though this is not strictly required this
> > makes it easier to spot s390 compat code support leftovers.
> > 
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > ---
> >  .../arch/s390/include/uapi/asm/bitsperlong.h  |  4 --
> 
> Wouldn't it make sense to emit an explicit error from the UAPI
> headers if a user tries to use them in 31-bit mode?

Except for some CIs there shouldn't be any users. I would expect that such
users, which use the kernel header files for compilation, want to run the
(broken) binary with the kernel which supplied the header files - which does
not work since compat support is missing in the kernel. So it fails when
trying to execute the binary.

Or in other words: I really would like to get rid of all traces of 31/32 bit
support without adding anything new.
