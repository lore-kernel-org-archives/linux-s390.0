Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACBE39E6D6;
	Fri,  6 Mar 2026 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812323; cv=none; b=KROlzIbD+wY2njzBYO+m3bT4WJ+RkWyBNkrpTJjaFOagKoTRFdfh6OBnDj3P1RHwgCOQwJabQ0TvdvHWDDgZfwWSYG07nr3fPV1PRoPR1pmHbnVcWqmsOrCLNNEc4cs1F0AExMk89MVryRleJ8G217e/gjmw3SIRXUp7IK9WASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812323; c=relaxed/simple;
	bh=JdK9g2gfSR6Myd7ctFUZkA3zICCqh+RjOP3mPo3MMEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDj0K0+unR8c/WPqbUEkbjAVlKuRED8HTYAwn1hGn2vCFQG6JsazXrnkO860SRtLGlBAb8QuFWwOVUzNgJWYBJTv85F4jyA1Toy8RPbxzvHZCeGqYCoi32sdkT8XSjxmUcQy/lQ093oXxOxZlYkqslLg8UlakFb1HQLbo4sJB04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F8uavd9s; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F8uavd9s"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6268xMwH1994861;
	Fri, 6 Mar 2026 15:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tQAB4V
	rPDQZra+9rDwtppxER8w6/J0FKsDBrDkfZpvc=; b=F8uavd9sFZdIRWw63cIKGF
	4I7QZCyXrpT6X8ayeM4pAf8ajlrA/OeOZ7ZJkRJXTint5SJu1NQ0lQL55lROSPo5
	4HZqmpSbGoAEFjGZouj4J8nqPwPsHvBVUcrDThYk13kFJyBLSpQ6B5ozFOlOqHZx
	A63ijChYiaHtybqGgmM39EoU1mIx5+CodKT2xkgVa1g82708lli0ruRrAqAItenz
	R/rjaM1QQGISEveuEfhk+AV30l1De+uOXdw8wZv5GmXnu7DaHOquDPTVEQWkOr9Q
	vjY+KX261Pfud4BHzegjeIrFIdPJkACu3XBk3UhtxJaNLKNI9A4+VprdUIP/Pv8w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskd99fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 15:51:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626DYfWV010335;
	Fri, 6 Mar 2026 15:51:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6kgcy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 15:51:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 626Fpswb45613404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 15:51:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EB8920043;
	Fri,  6 Mar 2026 15:51:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEC1420040;
	Fri,  6 Mar 2026 15:51:53 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.87.149.120])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Mar 2026 15:51:53 +0000 (GMT)
Date: Fri, 6 Mar 2026 16:51:52 +0100
From: Jan Polensky <japo@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org, irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] perf test: Fix test case 120 and 121 for s390
Message-ID: <aar4GKP1c66egZnn@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260306071002.2526085-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260306071002.2526085-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ST7yekmkW4Pq_8AA1H9G74uvSMzLm5Ay
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE0OCBTYWx0ZWRfX27akgMdQ/4DT
 SCrEf8SpU5vTD2TCic5cQGpTLuS2h9gN+qkNsetx3LcVxtzne4ZVQfaOHB+0OdzRPGNC1oPvig/
 1Pp/L9/qmp2HsymkqRDhCHhtjaCH6SFuQirFStirr5zOlyavSh0XdcgWMGy5tG1K8ymKp1Eyp/C
 y8RNVPRGd7MC5QhuDELUyFbb7BLsS2j+cjDLe4CmXWVZn7ROngsIEvN07gGDqi3xJXSlxQgaumE
 J7o1nVaUi7fRGrC/NCNO3Pv/MaypvUjpsa3DU6KchAbE71MVm5dTqEjUs+haQKGyeo38DJPgo+e
 AD0YM9FOZP0P9eBbgKpc4QYUnZm82Cu0vtuCA+1pqCw3owzRpJ0TlYk0/HmPNiP2NAp4lRYbKTY
 Pc8EZ4ECB/GrIWp18xqMXHymT5Vq7/4Uw1KW/8sFIZHAXRTP8D6OBwk2ZFhUbTQ8pkQHxJkalrC
 7l4J/O6vhA9i7/QMHiw==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69aaf820 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=yCyTqNsD1iSaV6jbGAQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HiYCNUaOOIYMQtqCkO3TEUUWCZCiyMqN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060148

On Fri, Mar 06, 2026 at 08:10:02AM +0100, Thomas Richter wrote:
> Perf tests
> 120: 'perf data convert --to-ctf' command test
> 121: 'perf data convert --to-json' command test
> fail on s390. It is caused by selecting the default event cycles
> which does not exist on s390 z/VM. Use software event cpu-clock
> and specify it explicitly on the command line.
> 
> Output before:
> ❯ perf test 120 121
> 120: 'perf data convert --to-ctf' command test       : FAILED!
> 121: 'perf data convert --to-json' command test      : FAILED!
> 
> Output after:
> ❯ perf test 120 121
> 120: 'perf data convert --to-ctf' command test       : Ok
> 121: 'perf data convert --to-json' command test      : Ok
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
[snip]
Thanks for providing this, Thomas!
Tested-by: Jan Polensky <japo@linux.ibm.com>
Reviewed-by: Jan Polensky <japo@linux.ibm.com>
