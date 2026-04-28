Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7FB3A9629;
	Tue, 28 Apr 2026 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361873; cv=none; b=aGrl/CW79Ge1lpvkll1DVpBLPQQKgoYQbZWhEQ41jqtB9pLRO2svVLzyCe14Dr8SdzPIDSqy18ZTC31zHpWMLimotdOuJ7sH6HH10UTDaZQ6MUuvofxl7PuS1UOTsY4ILYXHWJOM2hitIYWwluFGQoob01QgrfEgJ8t9tNbUBw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361873; c=relaxed/simple;
	bh=zDgsMvfwkf9zhMEC9HLnRKYEyKy37OQKHNc3sG3AEO0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Bnbev52ht5Uwjy6P1Lxla/YZJtUZ4duwHljh4mPIRkjNGNoryfaO/VdNZ3d2BHbX+E6RyY+R/0xB6m4lbVI+bMzMRJTULR+NVsHhB9v9m7ethIK8PalhhudBF6vffIOnG9NMiQOg6JHGruaEYAJMu7f96euci8zCK7IPHfOVuRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mgov2+N/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mgov2+N/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S4uGRD3076657;
	Tue, 28 Apr 2026 07:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zDgsMv
	fwkf9zhMEC9HLnRKYEyKy37OQKHNc3sG3AEO0=; b=Mgov2+N/4HPcStsoXkKD96
	d5vxL7wjZMZdvGAYWIi8RGT9pSzoHsAuZSchgAZjayEi2H2UiSVgUin6LvdQ7IzI
	orJpaJYNMpFVVtqafgE6axXolGTx0RCg6m4vFlgcFFnLSQmC2Ub4dqMKGFQT3Thx
	uhr4twcs3RD48241UZ7ChMT1RYhu6r7cqt1xlbl9VRUpMNWcRfKA/Wbbi7i3Hr9H
	DrescuH7+7DtJ5WQJy0lMoTmuYD1BIUIAv+s01Q2+8ew2/+pIHMzmktPGOonCCWW
	24OW/hVHdw48k3P5vjj7oIe4LCyRuNUYtlMNvr9LwFMlXcDDshceiUsTnVJiH6+Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44mce1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 07:37:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63S7NmuH013461;
	Tue, 28 Apr 2026 07:37:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9eh8ka7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 07:37:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63S7bgtr28770770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 07:37:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4286A20043;
	Tue, 28 Apr 2026 07:37:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22A3C20040;
	Tue, 28 Apr 2026 07:37:42 +0000 (GMT)
Received: from t14-nrb (unknown [9.111.4.79])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 07:37:42 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 09:37:41 +0200
Message-Id: <DI4M73BX1NE1.2YGMYI0XGAPDI@linux.ibm.com>
Cc: "Janosch Frank" <frankja@linux.ibm.com>,
        "Claudio Imbrenda"
 <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        "David Hildenbrand" <david@kernel.org>,
        "Thomas Huth" <thuth@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 4/6] s390x: sclp: Use sclp_feat_check
 directly to read DIAG318 feature bit
From: "Nico Boehr" <nrb@linux.ibm.com>
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>,
        <linux-s390@vger.kernel.org>, <kvm@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260423-vsie-stfle-fac-v4-0-32943fe43394@linux.ibm.com>
 <20260423-vsie-stfle-fac-v4-4-32943fe43394@linux.ibm.com>
In-Reply-To: <20260423-vsie-stfle-fac-v4-4-32943fe43394@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2dpX_CL-UNpUubeUw8xOx7oJGmvUs_rT
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f063cb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=1-9KTRBQuXGLPIKfmyAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2dpX_CL-UNpUubeUw8xOx7oJGmvUs_rT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA2NiBTYWx0ZWRfX+mUgADIzix26
 9cua9DqK3EfifevDI9fI+t3iuTmaJwK1BpJpdjo5tX9yy5bhE9G3BdM8zq/Ddqc6aznIwI7yRpr
 GViNfRK4LxN5z0IRRBA8Q98sRkLa5Cy+dIfn/2ibC1Kq/uY9+iXZD73kLGF9/DO+JXO5gpb0GJT
 gAkRGRcEFTZ3EC7dABIpYxtYZugQ64tziySFUuaAJEYRTqZZDcZhIPPPKbb2sEU6b1kOvqhAIH6
 33EGaUi8c9HimmIhksjzh4bsciacU06WCZaymM6hxx3EWKDAd6f9NTr9oq5L/fC6zIXy5N58iQy
 ha/927FS5gj3VMwA7SVmhpaH+5CQpRZNLqIyq7JaY+FPv02Y8mHTc7M/vIbYOKv+dOcN0IeoQOt
 heUTNP48EW/7AfW1DSzluGOpDA2oueytWZ7uM1dpKmFCV24kGb4DYIZmjUmZq3Ggj0g/65kVTIG
 UpkrHCEn1NvuNKIKvDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280066

On Thu Apr 23, 2026 at 4:26 PM CEST, Christoph Schlameuss wrote:
> The additional entry in struct ReadInfo is only used to set sclp_faciliti=
es
> where we are aware where these bits actually are in _read_info. So it is
> more readable to directly check the bit here.
>
> While at it order feat checks by byte and bit.
>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
