Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7443DA5D;
	Tue, 31 Mar 2026 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979049; cv=none; b=qETJhKomhcnktZzP4ysHDa26muFcVjetTdVmxVzUP8cAolpAFYsFgnrQCkJ81mS+6tSmyjlb/LLVi/VPzJqzcYsb/Gv+/7jwP5dS8kGBggRo4pZVa6TC1kQUvD6lmam2fzUOf+IntTCSlVS44bQ8Kn3Xh48otRjvTvEoBmubRfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979049; c=relaxed/simple;
	bh=2BnY2lciShhql8E6J7zoo6irH4k/8CncSpOVcnrGZI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAK3/ZNi+9BkL1Rf/7iTykOXQ741HigDohlBkgpF9iLAcjTjwQ7P3KQdEsxPIWSSosgPcCa8uyBW0JufoaJHvHBoyXaHevK8A2Z/Di2T8grhgBYzi7fX55hQmWGFubhn1YWfTj1E4kKX0fSrw06vQ/MmN0Oh7ioXuP+hmdsQ7qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j9+xhrID; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j9+xhrID"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VAm1Zq726020;
	Tue, 31 Mar 2026 17:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/XfIou
	oBIfJj614uLcM73w3mxF76QqsN7eDk0tK+ebM=; b=j9+xhrIDQM5ndTMWjrMI/n
	XsgJF1Y3AFadrFwfVsbT96pqYcQJJEMGfWvwT3oCvlk5kBe8NISDCh3q7bXA8G4Z
	cJiLaU/byoWGIpaC3rWkb5eIfTi3CMsLvYVP8zwO/mQ1AWOLtajcdMp8Auv/Liju
	sfOvndMjWbYEZ+pnUCgJhQcKL15lZF23I/TfJyaMcGpt4fD9jL5nn+c7LvRmGvcO
	TrBpJe45xRbfQwqVhPzOvs2X5mkgohAgj1qrFEwa4zWI+BPlnZvamhJaIT1RRcNs
	cfV3jt2BtBydn1QXWIPARO6cK60Od0PwVHJD2upyaJdDyRjQ1FeT4+cIke8uvK2A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcc53s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 17:44:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VGYhI2008703;
	Tue, 31 Mar 2026 17:43:59 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11hysn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 17:43:59 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62VHhwJt11076130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 17:43:58 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 082045803F;
	Tue, 31 Mar 2026 17:43:58 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0FC45804E;
	Tue, 31 Mar 2026 17:43:56 +0000 (GMT)
Received: from [9.61.9.136] (unknown [9.61.9.136])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 17:43:56 +0000 (GMT)
Message-ID: <5fbdc438-3b5d-4a3d-bb4d-cc71a215ce93@linux.ibm.com>
Date: Tue, 31 Mar 2026 13:43:56 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 6/7] vfio/pci: Add a reset_done callback for vfio-pci
 driver
To: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        kbusch@kernel.org, schnelle@linux.ibm.com,
        Julian Ruess <julianr@linux.ibm.com>
References: <20260330174011.1161-1-alifm@linux.ibm.com>
 <20260330174011.1161-7-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260330174011.1161-7-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cc07e0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=r1p2_3pzAAAA:8 a=S9AbbzVI5GFJ9J-4nxIA:9 a=QEXdDO2ut3YA:10
 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: aT5JIYmdlMO_wjmwOHpMK8SjbBvtrWFJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE2NiBTYWx0ZWRfX+6JW8YDTSP/q
 12ywkbj6FIJtbWFaHp273FyZfWqZ+TV5/DXxn9+VToJix2ZeWSLQi0B6sZAAOsDW4c1DvS7lcqS
 UL9Di/T5Mjjhtfdo0NNv7xz/BQV2aiYTzZPOgr0tyeyGGwJTDcJ/jmbH0dOvJwtdGj39lMZ99tZ
 pVeCqgxKVFj7/eosNtuiOtc4rvMcRQG1Uwxqr7pNyHAM+o6xc+EqUNGlpmDYoiFj1DWGxgghIjQ
 D7LSddaff/HRwjTUBvSV0cu66Pnzpcn0AD8r+mO+m/eepVRNXMK4fevLwymtKEE9C4hg8Dxsw0j
 AWnypYAYsXy1gH6gMNwuvxdcTRCqDjXPJVa4mA9XwUeNXD6jxtM8wsIGO7qbN7D9/J9+OnI4WiR
 xb2XAjwSI/QhacJFeV33/E9dDVwZGxQw0nypZjj1lXBT0yO4qaYmy7iaDDh5k9P1IsxiAUIrn5D
 68AhIsB+lxaL+dnL6bw==
X-Proofpoint-ORIG-GUID: aT5JIYmdlMO_wjmwOHpMK8SjbBvtrWFJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310166

On 3/30/26 1:40 PM, Farhan Ali wrote:
> On error recovery for a PCI device bound to vfio-pci driver, we want to
> recover the state of the device to its last known saved state. The callback
> restores the state of the device to its initial saved state.
> 
> Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Acked-by: Alex Williamson <alex@shazbot.org>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


