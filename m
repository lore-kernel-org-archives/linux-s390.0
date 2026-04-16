Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947C578F2E;
	Thu, 16 Apr 2026 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776325864; cv=none; b=Kxxw84cZ11Z2r44kaFXqAIqiR+KsXHmmlY22HWZkG+iMUqJaEGVtjrhlZh6Y8aeV4Hz22gIUVLQmOyaPJSs+JFj6YrHAGcecCMRLsS07HYIUEDJzpNCqVLFLvKn7UCJrPpA2dvKNevzmYdb7ZhMi93UjX8Surrge2cRZ2Uma/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776325864; c=relaxed/simple;
	bh=txtlxy3rwBvjwTQ4Rz6t/0fD4UONZD79bEcwncsEsGE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=i5OsH436b7TaTYqNS0GGX+4b1BHSlXLDxWl/DnQYb/dr6you73AqkHSFJVNxKsMlYfRmy2eYOhU/mLiwmHhnSFynQ5lfysv4iMqhcEaFQLwTu6H3TS64Xv3dEnY/QKVmcA0an8Vv0f0HIa08iTS09VhxKAsejvvSjN/Y936agZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=duXscRbD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="duXscRbD"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G0RVbk448054;
	Thu, 16 Apr 2026 07:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=txtlxy
	3rwBvjwTQ4Rz6t/0fD4UONZD79bEcwncsEsGE=; b=duXscRbDp1m3NiKx8RHzj6
	XUPwCEz1lEQHY3mVtu5HklmjR12dIH9ighDvwrEJLYRfpNseRCHiBQYn6ZluqHyO
	1XuyqeIN/bEUmpR3dJEzm0J1hSEy2CubJki82c0O7eugH/8I9VIQcF9VThpA0A3J
	nJmS4Z4a5PQOdtBp8m00XYV8RxASIVdJOb0Hvqmi5EOdLd0KSYFXwyM7TftABzuT
	XwdV4lP/RGxMU5IalA95wTlF7FXyDMzSFupEfjdI2bJ0wTVINIUmEVk5QW0Or+UT
	yd9hrFNPPkpf4yM4Qxp6UTS3LndH21Ci4yP94UvKrEvmWSs/OqJEsRZd7slI43IA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89nmb69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 07:51:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G30oJH025629;
	Thu, 16 Apr 2026 07:51:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujsqxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 07:51:01 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63G7ovPn15729112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 07:50:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FDD92004E;
	Thu, 16 Apr 2026 07:50:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 350ED2004B;
	Thu, 16 Apr 2026 07:50:56 +0000 (GMT)
Received: from t14-nrb (unknown [9.111.59.166])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 07:50:55 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 09:50:52 +0200
Message-Id: <DHUEYN8UX70O.1GM62DLEDMNKZ@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <nrb@linux.ibm.com>
Subject: Re: [kvm-unit-tests 4/5] lib: s390x: snippet: Add function to
 create a guest of specific length
From: "Nico Boehr" <nrb@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260415085145.91197-1-frankja@linux.ibm.com>
 <20260415085145.91197-5-frankja@linux.ibm.com>
In-Reply-To: <20260415085145.91197-5-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YAZk5Iwf32v9cfl48FYClZuU6r8tYbId
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA3MiBTYWx0ZWRfX6UxLRQa2uYcD
 yi2OOM3+wpVUxVUHtOwYA7b54KWh5WRzdo+0TgpG1+bdgVL/K/HM7gt4dh21qKN9VwrtzbITyt+
 sV/LDedE0V9K08NkFDxGh9xPECiEa9WWcJ9aZk181OA3CLDsfEtO58qyeL0fvJH0L7o/ZJKKc87
 Qw8V65FdItr4ij+/XHnlrCxKkfWVCiRGaxyHqmY9dipfCdXfhGUQzR43kiFf0S8jrR9ncKs3NQQ
 sBeRVPlTmeSLQJ06yNqLWu+HqpGUr+5cQQ93JlMBaH/1z7GYcdo7tppmrr1UircROOIFTv4QM7r
 dctTLPPXV7AgC6c7VUjV9Vj0vXDVnJ7LK3Q0YZzTiXPs8XqnGRMuNP/g9GJ2BvOBYgSSQW51cWR
 Rc5u7uaEBXeTCICccrhQG0RP5a4qXMa82L8wTicy5y12HwkDdwyuHx/nQzs/z2ejrBQ+hV5zY0k
 wrsquQEJK9TZY3MSDnw==
X-Proofpoint-ORIG-GUID: YAZk5Iwf32v9cfl48FYClZuU6r8tYbId
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69e094e6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=P4jGTtDLmVKjvNjmM4IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160072

On Wed Apr 15, 2026 at 10:45 AM CEST, Janosch Frank wrote:
> While 1MB is certainly enough to store the guest code, it's often not
> enough for memory tests. Let's add a separate function to allow
> arbitrary guest sizes.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
