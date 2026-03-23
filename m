Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC6C2AEE4;
	Mon, 23 Mar 2026 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262986; cv=none; b=uXtJtEuxuER2iC9omg5VpTLknWIfvGL4UZ3doqYUG5ifHfE9rOtoZKnZyvd4Rs21z4DoFJh0tNlf3IE0ktT7ncnehX3iQZ90Zq4FlVfUYFO9sD8bakTvhuwAHZrTv+lHff7eb2szcZFKoQxs0qtT3jXWbPMqIG4vZtpYHbIqKho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262986; c=relaxed/simple;
	bh=plaEK7F/BIXo3UH40704G6KQ+iux/fnNWamloR0FWsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXDJXMi9PZRvLNKJIBsbpSrhbNCKfGs5CxggGkuVISD4DG6MQNTtDdwzDQyPA6/2B5+1CLYmCx4ZaZgak3M9cfi6cPNgCS1y45ks5+63amoNfHfsIhhaemO3UBl7zqKrNrRhflCMLASfj78GQuf0JD38SUj20b0oSI9ycmemg60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o6yWFken; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o6yWFken"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MLt6WT488451;
	Mon, 23 Mar 2026 10:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=iNyOIrF5wDIdb/oHPt5T4RT06Qsl24
	pIQ7tj2EUPFqg=; b=o6yWFkenKX2+VmOuoXWjUZ26hdnOxE72uONc/gtpU88JTG
	xrow+GUk3X+hkNeFR4axiDJSnekfECgQavCJ/f7UPi6pyv7g1dGvwjBuG+0UW425
	1RCq7QazKdbkOOw/YE7ASPolGhcirZzcSe8WgRKgH4U1v0PGRgj2GgwvSXRUrwRS
	kMGxcbUy2sd94lXr/vnyFCZBjX8MUGlg5rk927Y2dmFIEmTPLyHvJBUbEjOjawyb
	y4tR8wtF01SaQlY5THHx0PEuTeOvo9U/U9zjj6ryjRTRvVuq9OyjNVZ96Rg2XouA
	TPWX7fdP57BGtvkiKj6vboeY/qZCPg+nHO00Om2Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kume6dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 10:49:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N7po4I026681;
	Mon, 23 Mar 2026 10:49:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kmxf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 10:49:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NAnbNw46006740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 10:49:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32DA52004D;
	Mon, 23 Mar 2026 10:49:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB05620043;
	Mon, 23 Mar 2026 10:49:36 +0000 (GMT)
Received: from osiris (unknown [9.111.67.16])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Mar 2026 10:49:36 +0000 (GMT)
Date: Mon, 23 Mar 2026 11:49:35 +0100
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, gra@linux.ibm.com,
        schlameuss@linux.ibm.com, hca@linux.ibm.com, david@kernel.org
Subject: Re: [PATCH v2 5/8] KVM: s390: vsie: Fix refcount overflow for shadow
 gmaps
Message-ID: <20260323104935.66303-E-seiden@linux.ibm.com>
References: <20260320161542.202913-1-imbrenda@linux.ibm.com>
 <20260320161542.202913-6-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320161542.202913-6-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a16vKRFmG3spi2_pw-qn9QQiHLe0hUj5
X-Proofpoint-ORIG-GUID: a16vKRFmG3spi2_pw-qn9QQiHLe0hUj5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MyBTYWx0ZWRfX0y5iFchZSz3+
 gRybnv2nGn3cCGV2wrbher7DO/0yyz18A1LVmh1jVPJ2zukBw+0bBnMxY0apbEM+x/ORemLz/Gm
 wt0N695QF7OOJ8TO7mUH2yeI1nENN/UaFpHT3saKIbc9BYbBej3GJrXGbay4/mj2WrXfrCDmnJz
 AO6OJsvyDI9zN9uQTjTS3KDZrqQ0gzXscW7e7WFu4atH0FHlGG1V5bLwP5wY64iKtOUSk/ZmUja
 N2x0maTRfWaKOIBizRCkGuRn98Y5c2l1sy1aWTqCz7Pus45/7KfamBhmd37SSkQi5JRVYbPuiYl
 e4nfATCzuCc0GL/QNBOgRQscRy3knPDibOSu5N8TFPCe3Q0f4bIpf465E+oMnigv2pcB9mRwy2m
 qS0W8V6hIpwBIdSYW+cf3W9cbbeJVmEA5FIkjIsthjBVh9R62ls8lJnBeQ9rTUbk39QrgVqUdqy
 MPLWVIlsQmnNyqmi8Ew==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c11ac5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=S7tHkTOIyoP8fopN8bkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230083

On Fri, Mar 20, 2026 at 05:15:39PM +0100, Claudio Imbrenda wrote:
> In most cases gmap_put() was not called when it should have.
> 
> Add the missing gmap_put() in vsie_run().
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

