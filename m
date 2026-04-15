Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEB32E7165;
	Wed, 15 Apr 2026 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776250874; cv=none; b=PjuKkzlJJORrPnf9GVN3OVdByBe1vv0MkCKx7Au/MHSz5QDB7wP6B9a1Xd8KQTC7ve4gUEiEb2xfrh12pSGxV+gSH/UPX5QX6NwSRi7gOb8IYxeJL++aoSXkxhvYpLRZyIYvYqgwbYztflt0RtXEk6Fk9GYUozq7xqnwNU+wtm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776250874; c=relaxed/simple;
	bh=gY7usLiZwYcEu4uG7lvPT7zlwVf/AAV+bMA+/3plgMk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GkwmwyM3ky21VDkZTzc+GTimHIQ3A+6DpAiBMWEBDkjHzIA3dvRqkQIrIgYOfo6Q79+qXAWzM5yttdUFXYOKSCk/D5vasSQvvy6CRePIhshl94P3jM7LpiX/2sqyZpa9UCqoyfzHNABDhnMKGqzopOqEYotexFBwvE3CW0PVOd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R75rzn6t; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R75rzn6t"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F2Yj571733184;
	Wed, 15 Apr 2026 11:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gY7usL
	iZwYcEu4uG7lvPT7zlwVf/AAV+bMA+/3plgMk=; b=R75rzn6tr6Myefve2uGIW7
	hWeiKfLlKfD4MZ3weUI+/hoOJv1OL6ol1c6GXtCfUNxAa/2v7U8sCypGFQMFLMTY
	BaOh8gD2gtINIUP0ikaWPIipwWduj5WUYEbga8XB10Ll4WQmQGXrz8r18pG+0r+X
	X32NoSYlnTqJFCEai25wfb2iiEbsbwckeve5gGVi1frMjimEhq78/FAxTnfCAXrc
	QWK9crjDKto4fHYKW0pDGB8Q8/c58e93To6NTFBRNk+PA3qnYVbucmUVr7ILGGab
	UD7Q/PkIkP/AxaZjM27CzG6LH1UR9wLNqSoHTy18Jc3PWLdmdqz+F/PMh7wjdO2Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89m77cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 11:01:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F77a1l015666;
	Wed, 15 Apr 2026 11:01:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0msp28r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 11:01:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63FB14ZD31850888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 11:01:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6941620063;
	Wed, 15 Apr 2026 11:01:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44B4C20040;
	Wed, 15 Apr 2026 11:01:04 +0000 (GMT)
Received: from t14-nrb (unknown [9.111.91.157])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 11:01:04 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 13:00:34 +0200
Message-Id: <DHTODC9X9PPG.26C1S6BQARFAD@linux.ibm.com>
Cc: "Janosch Frank" <frankja@linux.ibm.com>,
        "Claudio Imbrenda"
 <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        "David Hildenbrand" <david@kernel.org>,
        "Thomas Huth" <thuth@redhat.com>, <kvm@vger.kernel.org>,
        "Nina Schoetterl-Glausch" <nsg@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v2 1/5] s390x: snippets: Add
 reset_guest() to lib
From: "Nico Boehr" <nrb@linux.ibm.com>
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>,
        <linux-s390@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260324-vsie-stfle-fac-v2-0-5e52be2e4081@linux.ibm.com>
 <20260324-vsie-stfle-fac-v2-1-5e52be2e4081@linux.ibm.com>
In-Reply-To: <20260324-vsie-stfle-fac-v2-1-5e52be2e4081@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=69df6ff4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=iVhpHZk9LX-LbS02p1EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MlJNlsclYkPznWTXWQp9KFLgqBZfIWhU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA5OSBTYWx0ZWRfX0u4GzF6s82jv
 IZgyAOI6lpSH0CnR0WOJDfj7JSaTWbW6ykY4IB2/IjIdrmQVngomtuOndhafD/6wXp0etszPujX
 yhBQWW7k/pbcuHoVRih4v6curXKJ2/Is2H3Akeka9XIbfhmhGCdC4R0DTRq5eGrSdnYSEIqBGnI
 ZtKb4eOGuabNnqEhDJooi1apoqTNASoNW7vQFVT26lBIkWt2UKAVlTvVNXFFtD4iJwTbeZ3GQso
 Kktgvglq4tpH1nZqzoADTIEVILic/BwfeDE4vjuU45fXmIoAa5IGeMlJDN9Wg2gEH/13B4xEBJA
 eT4x3Pk9U83EJUh3AiYN2NHrmBgWc5rCb/DZxJskYoPnO+1Ivf+9M8cf8bW+VGKcJB4DVgE+y4L
 mKlRdV7BUn7g0nLg6jbh3ey3OZlDmZqcCZLiholvcZGaJ76MTagqJZZUZeKHa8/jvAYmHFD6W55
 TducQp7TX947uuoXC6A==
X-Proofpoint-ORIG-GUID: MlJNlsclYkPznWTXWQp9KFLgqBZfIWhU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150099

On Tue Mar 24, 2026 at 4:28 PM CET, Christoph Schlameuss wrote:
> From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>
> Extract reset_guest from spec_ex-sie into the lib.
> After reset_guest() the snippet can be executed again.
>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
