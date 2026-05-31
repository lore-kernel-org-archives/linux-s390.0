Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8695113A258
	for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780249782; cv=none; b=ii2R2g9Hgi8fjdu0YKJMRTttoQbyXEmV3me4feBh5mpAnU+hWdBSQaBAZnt9oskQTN2s1eTBSHOLM7l0YyG25xfXbwZGmMJRB9H0uJtyBAuQVOv9qcA4BGiZVFPi4Po72s7nB0hDMWiDlXz0/E0/zSZCPm88hH3SFuTg71z/Ok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780249782; c=relaxed/simple;
	bh=MVDVeCGviTXqet2kgSQeihbhuMn6WlBLIv0ipxQVoVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcqOOW2Rxf+kTf5vzZzg8hgjykp1fLFDUwg2l0fYZ1uzpTgzxttyP+gyBZnUht3X23r+x/l/ReKvEY6IHyCpU5/X/JWBLTBo8e9dK0dhhgC3jVagilnQaWNzYq1vN+8ma6/CE2Uzbg7c6xeANOPDpxlW6FvFFhBbCyj32IAnfIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UljkPyOY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UljkPyOY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64V4X1GP2337749;
	Sun, 31 May 2026 17:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=w9UeaD+ZK1p5C3BEkkesZuaSE0sh22
	rnJkmuTDpQZC8=; b=UljkPyOYAw77dS/86lOMyPum3ne7zV/0XproFnC0QU2FV4
	mA20PLb2kI+MpF0vXISf1jE882vhQOoWZLP7B5oYVNdFhqC8tUey1Eeaj4brqDHA
	TCMOd7fXP7RzvjlcSysKwgRSle0wNfTwGzCmgBSGAsGkl2jtTKH7i6sw+pL/cku1
	6EN0aBvxDYUcmJO+06KwVLjeOZVBMv/YSaJ5ypIln3QrEZ+zaCNywBdftUeb/1yk
	N8HwMjlAYeB45NbGZpMiRRAequEhZs4n1s+iP4nsAA2O4SKb7vIer3OuRFhbtp9+
	8JiOYXf7pn6KULLjPv55D1NSk7KxietSGhf16vOA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpadw73x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 17:49:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64VHdRV9005789;
	Sun, 31 May 2026 17:49:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvjqmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 17:49:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64VHnSwi48234780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 May 2026 17:49:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 110C22004B;
	Sun, 31 May 2026 17:49:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FA5920040;
	Sun, 31 May 2026 17:49:27 +0000 (GMT)
Received: from osiris (unknown [9.111.22.46])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 31 May 2026 17:49:27 +0000 (GMT)
Date: Sun, 31 May 2026 19:49:26 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 4/6] s390/qeth: replace get_zeroed_page() with
 kzalloc()
Message-ID: <20260531174926.125536A74-hca@linux.ibm.com>
References: <20260531-b4-s390-drivers-v2-0-f7985308ed90@kernel.org>
 <20260531-b4-s390-drivers-v2-4-f7985308ed90@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531-b4-s390-drivers-v2-4-f7985308ed90@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1c74ac cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=kt7I_EveaTZZBW9BUTwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: imkJl19UvkYAtDnGmibKAvGhvW7gk9vO
X-Proofpoint-ORIG-GUID: imkJl19UvkYAtDnGmibKAvGhvW7gk9vO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDE5MSBTYWx0ZWRfX+evgLt7E41f+
 atza5kjmtZjgqEUPD4WyALAamncPfXOxxq/46lvWdNZdyO5x+uXthO5jXgcITMk3YN/4jaMnsC8
 Ce6Ab5iqURRPnLxgARWRh7d36Vd5QFquHDR3MdtwX1fzuhg6PK/fl5B5s/nrmLq6ZlRCX6aRB0u
 TafXIzuHsk923AoWZX7ZIHcBxbEVKvPTvv2ycGVymYk95W2ZCCqQyCeA/xe3cBiHY92YaxUpTHW
 41aBLvNIM++G456EfS2j4ec1aGQiy9sJO4+U+X6ToKOMsbKaASBy4H0deDdZ2rq7IFGbUMAUqxF
 yXdk7eIcj3G/mOkL9afltzOfU8gQ7n1utwE1wf3VFPCC64zI4SoaB0h/LED7GrDSnckz2z5axbb
 HUkEur/ZeTb2aVeyWMAzZu76YQ8x6dT89xnf/ztCwoTsTW3Bm6bLqcU1jvDR+wshX49/6Pu0FzQ
 JkuG3CZEXJVE0mmTLoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310191

On Sun, May 31, 2026 at 05:08:25PM +0300, Mike Rapoport (Microsoft) wrote:
> qeth_get_trap_id() allocates a temporary buffer for STSI system
> information queries used to build trap identification strings.
> 
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
> 
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
> 
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Acked-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  drivers/s390/net/qeth_core_main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
