Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FFE37C0F3;
	Wed, 15 Apr 2026 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252462; cv=none; b=Re77FrT6Wr1Nu8RK3BPjfmvXNURa7hz7umrfYzfRgbpT9bGdYnkZMljMg1hiZZqhUYgI3pII8/jVAC1THjTNNyRxcBLROQ6QzhI9R+UB5YmLEH/Mb54nc2rA8MPDyx0ecudqwGePm5svhnBJgEzCBO6Lk+/8f9sKJJxGmI6jtpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252462; c=relaxed/simple;
	bh=IUN2bvcsKeM/Q76BvAR1EOIsI3occlGpyXrIF8mBUxI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SgayriNxb8zNCaeUGSTiMJHBuTkhWbAzq67E4Lg2qylvgLnWmGdMBWxL+E0+Cu/wrnAhlJPzUIybGmtW1KserCBdVsNLBjEpNa55eaKqU82m4npcEuIMkum+9+e2mIfjJZEBM2OD665VDjjWt3P9dhtx+DMpgKPs55nUiOXhKu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CVGwsBSH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CVGwsBSH"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F5YmQV1804412;
	Wed, 15 Apr 2026 11:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IUN2bv
	csKeM/Q76BvAR1EOIsI3occlGpyXrIF8mBUxI=; b=CVGwsBSHHBHSoZ/4zfrd98
	dddSNTAb+VIunbwJylW0YlXCJpPxVTNTzL95WUQraX8vpH8AHyH5nqIo+WY+hN3R
	din2CFCvO8/07cc/OtVfKlIkk7CNV9rwZHgemzN49iswG0KyH6VmcwIaJYFB9WVi
	0uyoj9JXMy3ENXXGBVvYYVuvEc4zBkxyYH3aZxw3KdPZ2VCYWC5yJh18/pujAKxQ
	KmGfp6vCSDLLPJxq8kWlpIs7tYyCmazgcY57t2AmSY+8rvGR8CrNT9UkHeP87PK+
	606R8AQDF0Wo3shBeahDtlnqUmhbVnP8osIU91Djhz93riZyZ/Ur/rjBrY+2JzdA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89k79th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 11:27:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F8UXh6003581;
	Wed, 15 Apr 2026 11:27:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mne079-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 11:27:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63FBRSvS26149322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 11:27:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACBC32004B;
	Wed, 15 Apr 2026 11:27:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65E682004E;
	Wed, 15 Apr 2026 11:27:25 +0000 (GMT)
Received: from t14-nrb (unknown [9.111.91.157])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 11:27:25 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 13:27:24 +0200
Message-Id: <DHTOXW3QYV5N.HLO0JCM7YD9L@linux.ibm.com>
Cc: "Janosch Frank" <frankja@linux.ibm.com>,
        "Claudio Imbrenda"
 <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        "David Hildenbrand" <david@kernel.org>,
        "Thomas Huth" <thuth@redhat.com>, <kvm@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH v2 3/5] s390x: sclp: Rework
 sclp_facilities_setup() for simpler control flow
From: "Nico Boehr" <nrb@linux.ibm.com>
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>,
        <linux-s390@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260324-vsie-stfle-fac-v2-0-5e52be2e4081@linux.ibm.com>
 <20260324-vsie-stfle-fac-v2-3-5e52be2e4081@linux.ibm.com>
In-Reply-To: <20260324-vsie-stfle-fac-v2-3-5e52be2e4081@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xAWEx53Rrb10KaQOXbUlesiBhipmrQwA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEwNCBTYWx0ZWRfX+tnfaXIlLEEv
 HO5GIv4N8ecg6WoLiueb3R4OexAd/+6UOYj+veVwILOWSrrY2bVjLwVLtpOPkk/9nn9bSZsT59Z
 kFyPN41KKnDOQugvnhO6/O9xYnd/PJNyi+MMIXQl1TPC5Xg+DX6jK0g6VpVvqGyZIs/ogrZvzmH
 eOvp6XDSfVluK1XlvEHn87zX3gII52LXJiFUmwsFiY5eu0UiMNpDiSV2MFX20FG7G+Iz5e283xv
 r5PBS79Rt4U3E2zPsdMYCDhgFtm7CL1FKeJVzJeBMd77LbcpeaG0sjs1Q0oewCv4VZrss5LWgCI
 wFMhqOOWL9oZpxFcMfsFbc8lDYk8HEcSsKG7Ycjs3ScmqhyO1KMk1UAsvtbkcsvvUYN4rYeHwDq
 ETL7qJ2xsvOxqnP8LFWfCk5bX5lzkoi0k5VZQZvaZKlD5zE5dDBfBtdL2nUXMpuzIS1cjq8wK0W
 iAU3vG38B512Wd17GpQ==
X-Proofpoint-ORIG-GUID: xAWEx53Rrb10KaQOXbUlesiBhipmrQwA
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69df7625 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=7Wr9Dzo944miuo2bjUkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150104

On Tue Mar 24, 2026 at 4:28 PM CET, Christoph Schlameuss wrote:
> Reverse the order of operations to allow for early exits with increasing
> cpu offsets when reading facility bits in the extended range.

Would be helpful to add a hint that this is needed for upcoming changes in =
this
series.

Otherwise LGTM.

Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
