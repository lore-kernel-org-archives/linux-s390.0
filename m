Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B02A3AF662;
	Tue, 26 May 2026 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812027; cv=none; b=j71ZPvNnMmEeVhMY8CZRfTxrp9O+cOheCxrpiQcX665GWkNKs+hFG9yBVxOV3iBMJCZhZFuZO9PySQDPCbPDQtbXjQ1hNhmwoOv6g5ZMxNc+DK1+O+Vhpn0Fcd7VLe5yWATYMiqyDBFzl2CgHd+f2NryoNGVKKVr6idGrz84LTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812027; c=relaxed/simple;
	bh=fLCkY+ECz5JYBlnNKcpCdrR4WXEGJasWE8+0gmJZbbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoxKG5VouGPUNciuKBNgRIXyT3YR7XFnB8z9LtofzeKChmp9pXEyiK9SQpeUTsaFctvmFaFPta3uqZXAKIj8Do7KhJXc/+yyy0d8M4EN+BSMvHSFw6/FPFPjoPaaOCX2do8GqWQkj0f87b9Ky22BcRRctkReXGc1evfDP3c6xiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UOgKOq45; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UOgKOq45"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QDdnDR3049622;
	Tue, 26 May 2026 16:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Egr41r
	2Vtn6cptFOaWdgDaEFQiHKZjZ+/BS5pBFCW6I=; b=UOgKOq45WqoOe2XlubbWfX
	UaITliOKA4UefkmF6l5AFoH0bvzB3o4zZ95kM5zdXBN1hlgvtZzHOUYqrdm8HoJT
	l+Uor8kBAl1zIlp97XxoKyZ+lQSNUjNslESdJZeZ9z4yUCOEnJ1jkrPhKD91PpXg
	YL5vL3bi4qzBKMRaRc8iI2osV6NHqDpPa+0rZRaefeVggZanUL+rYVPqldOXSoFj
	7IX1AZJxOixSEX6FNociYH7mbmCUOtYo4of/Y1z4tn2tGzaGuGkhNs9LqFE6i1Kt
	xCjBbbc8kHoz+oxIiQ1giZ+IgAjmtCQkYCVd5X6mWMeZAMOcyZD4fEj4MzAEdWvg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4qbw3cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 16:13:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64QGAFgV020402;
	Tue, 26 May 2026 16:13:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebr2h23g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 16:13:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64QGDF9Y50397550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 16:13:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 411FB2004B;
	Tue, 26 May 2026 16:13:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21C5620043;
	Tue, 26 May 2026 16:13:14 +0000 (GMT)
Received: from osiris (unknown [9.111.46.212])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 26 May 2026 16:13:14 +0000 (GMT)
Date: Tue, 26 May 2026 18:13:12 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Jan Polensky <japo@linux.ibm.com>, gor@linux.ibm.com,
        agordeev@linux.ibm.com, ojeda@kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] s390: Enable Rust support and add required arch
 glue
Message-ID: <20260526161312.19291A8f-hca@linux.ibm.com>
References: <20260521165622.279953-1-japo@linux.ibm.com>
 <CANiq72kT7YEuMaM7wkOtCz8ZqEXbPLniA-x4L7E=B+x0zXt_2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kT7YEuMaM7wkOtCz8ZqEXbPLniA-x4L7E=B+x0zXt_2Q@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzOSBTYWx0ZWRfX/oZutKlFpXyH
 ZDEiwMaUOGYb0NxdUFJ+N/KkaFCi8IvtpCWbasw3q7kUYvzRVck13rsK9gYHmU6rpqJxq0T8DKR
 60SJ/xBEwSZitomr48dyqA/FfTwp0VlrT931AnWf1JdFsK2gBaSG2av5Pug2eJwXvOFjIPGGZ9Y
 J4WlVQ+4+NIUQfpARJ+BituiLJgMZBYENG7rOn/b6PabC/334EGafgCDfXw27cEK7xs8N8uRm3Z
 4LTgw/Gm+9ARsBB83/XMMFyqiZeb0O7SwujXu/pdcpPZ/voz68xDZXocl0QBjUDExeAlZMN2vjR
 wa/KLugboCLztv1qT+SGg19gunvDapd6firGWAUqgA8qF84drrktM0GZ6mlGfAJaoKmWK5Z6pGZ
 CnLV2kFAzTOf4Siy7dDoWl93DtV77HaULVdw2lXK9In6apfbxX5wi/dQsofW+QgX5ifXyWjMsaR
 OvhgTy6rGhIJ30EKasw==
X-Authority-Analysis: v=2.4 cv=KItqylFo c=1 sm=1 tr=0 ts=6a15c6a0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=G_bgqYzucDTkP3-IBUEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9BuDjQaYryfzv2VGIpYhew5RqxTHPrAn
X-Proofpoint-GUID: X8gstQJ2pxUZoNSMSaoixDyprIErK_2V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260139

Hi Miguel,

On Tue, May 26, 2026 at 03:55:49PM +0200, Miguel Ojeda wrote:
> On Thu, May 21, 2026 at 7:03 PM Jan Polensky <japo@linux.ibm.com> wrote:
> >
> > s390 currently requires a rustc due to -Zpacked-stack, and the
> > minimum tool version gating is adjusted accordingly.
> 
> This doesn't matter unless the maintainer applying this uses a merge
> commit for the cover letter, but there is a missing word, and if the
> word was meant to be "nightly", then the paragraph is likely outdated
> anyway :)

An Ack from you would be appreciated, even though you made it already
clear that this series looks ok.
