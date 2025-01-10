Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A9F1FFC58;
	Fri, 10 Jan 2025 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736495163; cv=none; b=JQkCnNPtcCq3M4QEMCJkKkmH9DmOqFwqPmfy6UTUBv4NlLQQiLQo6A2lM83GBCs39STqrF5SVe7GwizlvMrUKRDl3C0oPcWOiAPX0lo6CpobxFMQqDwyt9QS/MbByg15kJBCzm4PXgwq+WaieWal/usZhOsarkblZpdmRUcdcX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736495163; c=relaxed/simple;
	bh=TaN/YVl+XMUic9yzN1PVn4S4r+x029ETZNwY8Jcsy28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwdJcMK76knfAX1I2U2u7Cbvu5RH4k8+nmGIfkB6oTsTlauTegBgDEP8SKdUOHsLfNA4Ai3iYJ5YsKP1HfZOrzBOMM12rwHofmrhob7Ngn5DKxDiI02qYDMf8iFImwgrJmAKlvL+52MvUeKKFvE6LuY/0jL3A3Ug66FsU1JVZ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qbW4f8XY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qbW4f8XY"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509Nb4sb020087;
	Fri, 10 Jan 2025 07:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=TaN/YVl+XMUic9yzN1PVn4S4r+x029
	ETZNwY8Jcsy28=; b=qbW4f8XYwSQcuge7SfzrAFyTqSo3qEOsN8xMF3xyiF+gW0
	RwxEuUgefU19gVT8hZRBaaLKJffShBPnrw6gcAS4yxv4jHf1aK7Fu64fG91/OnLq
	tf2c7XyvOPhjFx3sAQClheWMX1ThaPgUKWbfXXyUnG8QSJ5mfGh2xkCA4ba6w8aF
	GQntvnG2zI9DHDowHcpERqiy92b+LhUUzaqaH7UYKi+x3U2p4EY+uR9loWFKYb2m
	/ZCy9M9o3upXXi7CGRiRaHay9NSY2is6GzFE5HaH/PNb4zPEb0h6uBlOCbXfc6ZK
	jsgqr7CELMtPvk28AE9HHPSKqvex1UL6cdUZTa9Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442r9ase9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 07:45:57 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50A7jvah028978;
	Fri, 10 Jan 2025 07:45:57 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442r9ase98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 07:45:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50A5xHRD028054;
	Fri, 10 Jan 2025 07:45:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yhhkgxq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 07:45:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50A7jss152167072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 07:45:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB2A12004D;
	Fri, 10 Jan 2025 07:45:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55B1820040;
	Fri, 10 Jan 2025 07:45:54 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.93.19])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 10 Jan 2025 07:45:54 +0000 (GMT)
Date: Fri, 10 Jan 2025 08:45:52 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Weikang Guo <guoweikang.kernel@gmail.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] arch/s390: save_area_alloc default failure behavior
 changed to panic
Message-ID: <Z4DQMNCayUHlwEol@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250109033136.2845676-1-guoweikang.kernel@gmail.com>
 <Z3+ECLf7LHQe+Mdq@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <CAOm6qnkoKjrUXCbhCiSYviuwCRVES1FYCy17fwATtyZ+M=Aw7g@mail.gmail.com>
 <Z3/VoAaSQF5Tcy4t@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <CAOm6qnnxvVfxfoKTj8eO3iqZ9oj__JMJ8o0cH2fZuKkk7gVZYQ@mail.gmail.com>
 <20250109164315.b21f40e1b757b1cf9eb7e042@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109164315.b21f40e1b757b1cf9eb7e042@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DiTpdXiyvd8k4Mwu2S2MNWuUt9wEd6xr
X-Proofpoint-ORIG-GUID: UUGlbVpcvpsa-5ou-jh79m4dOSbPleoP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 mlxlogscore=534 impostorscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501100061

On Thu, Jan 09, 2025 at 04:43:15PM -0800, Andrew Morton wrote:

Hi Andrew,

> I'll fold this patch ("arch/s390: save_area_alloc default failure
> behavior changed to panic") into
> "mm-memblock-add-memblock_alloc_or_panic-interface.patch", v8 before
> sending the latter upstream.

To s390 bits of the folded patch:

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!
