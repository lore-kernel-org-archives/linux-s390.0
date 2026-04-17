Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031C03101B6;
	Fri, 17 Apr 2026 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439726; cv=none; b=iud6ZJwlOdsO4nHd+eUHoVuYEwRbqMorW6JFg9AvEGA7sA4X6lipgSWLI18Dfi036MpiazFu7Mw4ncIpBAm12S+Mb6KSNazAkUxAds3qYa9i1J3svJIUyaLgNfPI7tpGpnEHRyd2YZI77c+ApRkQYCIK0TVgIt9nA01IXejJ+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439726; c=relaxed/simple;
	bh=+zYxfnaS4VHMDvEQXO0UYOWM9TO+YvBhxCM57j5t0k8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=HGcJonWLHqG9rMyEGtVNWWuo1pGw1S80hJUXZAkFGy1QS8Z3REfn9/ZBpKM1ZV1FVOHPacYK1TjfbhhWhEEat1c01LHWAGUkYBaFwPvnxkQi/kTVIrLQRIGTktVyVZ/T6HSqtngFtJqavizGkCSGWisTJeRZxngHjuUSaSHJ6tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WW/4Ebyh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WW/4Ebyh"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H69KJU115524;
	Fri, 17 Apr 2026 15:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+zYxfn
	aS4VHMDvEQXO0UYOWM9TO+YvBhxCM57j5t0k8=; b=WW/4EbyhseiqjYBjTxIogG
	Je/6s6bSdyNuBZAVUgwRpluYHt5YyXks29Ll2O6854nbCPrHpZYoVS6brzo304/Z
	VfxAjJIm64hBKUbouKMS5i8WYQwvJOjZhXv+9TBsuDNwv20YCYH2FPJN6WZx5eQj
	hIR9foB32ElQ3umwDsJYnTTHJm9vjYSgreK0UfgoMsAEtbQlJwhvcZQ99wWDSWA6
	fdlHJyi4FsNXRy7tYa97DNYh+CcO6nfUpjcfWzLCLgIsnu2bRfH8ekwHhBwXUT06
	ozjg/kjESitglA49j+1+OQ7RCESOHsKGWCp9QMKT+E/7rdOtrXSkxg5X4WNw5Haw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89n394m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 15:28:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63HDKeBs025862;
	Fri, 17 Apr 2026 15:28:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujyjek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 15:28:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63HFSarf43516392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 15:28:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B74B22004B;
	Fri, 17 Apr 2026 15:28:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90CA620040;
	Fri, 17 Apr 2026 15:28:36 +0000 (GMT)
Received: from darkmoore (unknown [9.111.93.164])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Apr 2026 15:28:36 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 17:28:31 +0200
Message-Id: <DHVJBL6GYAUI.3TGZE1HTO10OE@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Janosch Frank" <frankja@linux.ibm.com>,
        "Claudio Imbrenda"
 <imbrenda@linux.ibm.com>,
        "David Hildenbrand" <david@kernel.org>,
        "Thomas
 Huth" <thuth@redhat.com>, <kvm@vger.kernel.org>
To: "Nico Boehr" <nrb@linux.ibm.com>,
        "Christoph Schlameuss"
 <schlameuss@linux.ibm.com>,
        <linux-s390@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH v2 3/5] s390x: sclp: Rework
 sclp_facilities_setup() for simpler control flow
X-Mailer: aerc 0.21.0
References: <20260324-vsie-stfle-fac-v2-0-5e52be2e4081@linux.ibm.com>
 <20260324-vsie-stfle-fac-v2-3-5e52be2e4081@linux.ibm.com>
 <DHTOXW3QYV5N.HLO0JCM7YD9L@linux.ibm.com>
In-Reply-To: <DHTOXW3QYV5N.HLO0JCM7YD9L@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE1NCBTYWx0ZWRfXyHqk7c/q2bU9
 X07eiSlS8aDPY3NVEd9IM1M2QQaLorCbB8KbBi45lMTRzf7ahxvLblYYX25YG6NPtgUinlPjn2n
 +v20I8+eZXxy6MxUlyMP+8IQWo/mxOl2BGRdVSaNDcYLfR9xiJHO4DfI/Q9mnbiDwtpITEUn0dT
 ddMFbEXx+b8Lx1V7mXMlAmagIDw4XZAJv844Snm5s9OflOqeDQYhR8dn54s0BLFZeJa2VMGL9ok
 W2Xo9euhEssvPXWB5b2PPhW+wSSpRlPk4yyTuZ26/1AxuaADLmahujLcYNx5mivHw8m2Lw5V3B9
 JI1JeErF/2V0c7rwCsTtR2lxrQjYHP0NJclOcvfUT8lTVQiFH2B0YAw7wqFXP85OhJ7+COI8+1Y
 NTXR84cuKLhyYbJ22gunzqSO3Ao+BZs/ZtGrWFIV1+7OterLAKK+ISrvJXcGJNjS9yk7aSb5SEh
 33oiFdmYnuu7I89NVGA==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69e251a9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=watNI3nhYjjan4-aowwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jQp4_aQH1nrQxDDmZp8q5nidL86wOmEC
X-Proofpoint-ORIG-GUID: jQp4_aQH1nrQxDDmZp8q5nidL86wOmEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170154

On Wed Apr 15, 2026 at 1:27 PM CEST, Nico Boehr wrote:
> On Tue Mar 24, 2026 at 4:28 PM CET, Christoph Schlameuss wrote:
>> Reverse the order of operations to allow for early exits with increasing
>> cpu offsets when reading facility bits in the extended range.
>
> Would be helpful to add a hint that this is needed for upcoming changes i=
n this
> series.
>
> Otherwise LGTM.
>
> Reviewed-by: Nico Boehr <nrb@linux.ibm.com>

Sure, wil add a note to the comment about that.
