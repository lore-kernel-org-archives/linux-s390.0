Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B039185B;
	Mon, 23 Mar 2026 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262857; cv=none; b=ZDuuWMMos2f4ssq5NL9r49AbTi8B2AixuG86IauwTov3g8Cdis/fWOi93kHGUuecWqmJhGP7c68e/gtrzQX1y8GDYVUFKbmyfIaXPALb5QG2dewA3BIz8M2yFKQ6MUAU5AxMt6NpdCEtLdFVuF7rG++h0Calj9ex+c356jTFpZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262857; c=relaxed/simple;
	bh=P6JQgVA1Zc5GIn+YZ/SlGRGAw2Qzdjj7zYLuyiuJwkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwFG7PJUj9DgGDvSm5HZoCUT81tXR8yB2FjMAba2PE2hTG+UcBFy+mWo22CTk4Rlhwu0r7koQLt4bCggY0SVmANttFJF/Y03jfZIG+hKGoK5VaMQsFqp9R5Ln8auLlQQaeI+ZPqJVpRE50HbO+uil8AjxYhm3UaT1lZ+B3E3Q3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QVSpeghQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QVSpeghQ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MHFTMQ4160176;
	Mon, 23 Mar 2026 10:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=j7x7ZJW51hGeiiX6BU92vM50HI4MrB
	YIP35TtIAx7iE=; b=QVSpeghQWdF6dQOXBZQI+eQE4ECdWXLhcEcGqXkY2lxD4A
	ZQVrOSOEkhT8sH+3IruT46PqTvzIxHyrXCtHBWsCdSTdoZw4eG9EedG4C6V2ctGQ
	6JAs+wVxFE0gQMA02PYqmzYkYXiFA5ehsjX+ETikeG8U7CBw7dF7qwA4zQBcXxLG
	NdaaHqFP8wjPHrUk4fwAdpZUPh5qkgWZh9iRZHoi4ui36kPOPpriUZBhpFYalk04
	2rns+5P9GXIcdzm4N6AUYIsx5M3aoh4efiKXc7Gk/o9E4RB4EwwisXQzkV4ZBI4n
	hZfwe5jbpoKhgQYeQTrCV85aMj8+PoLQh1iKEZMw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxpe5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 10:47:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N8CIdh011824;
	Mon, 23 Mar 2026 10:47:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vjvtrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 10:47:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NAlTZc40894954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 10:47:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CDA420043;
	Mon, 23 Mar 2026 10:47:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D58312004B;
	Mon, 23 Mar 2026 10:47:28 +0000 (GMT)
Received: from osiris (unknown [9.111.67.16])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Mar 2026 10:47:28 +0000 (GMT)
Date: Mon, 23 Mar 2026 11:47:27 +0100
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, gra@linux.ibm.com,
        schlameuss@linux.ibm.com, hca@linux.ibm.com, david@kernel.org
Subject: Re: [PATCH v2 4/8] KVM: s390: Fix gmap_link()
Message-ID: <20260323104727.66303-D-seiden@linux.ibm.com>
References: <20260320161542.202913-1-imbrenda@linux.ibm.com>
 <20260320161542.202913-5-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320161542.202913-5-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c11a45 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=X0Xe0XUrc79U-KVWp3sA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MCBTYWx0ZWRfX6HCyhSf3nx7w
 FtfX3+FUvfCknCtz+kebhiQse/EpAUeIoOdOA71E5CBdDzGhr0fW0lGVV7s9QhDfsTegrfEJjta
 6GEy5QE8b6PJD70UuqK2go5t1f5STy8xK0cukR9y3eZALRhDUvPQltndq9F2m8d++OdxVl0ygEa
 q8XIyEsTHPNLuNa3fPUSHTZP818xAURP+oLF7Z8qs0Gw2SA0qbGxHYIA5CMQMscE4yVcfcrGtlk
 n9trRfPG7J6j7YSTsW7You4cEvYkzQ062ea32t3auuoDrTg6rvzhABgFJJ3qsWI+R2V2WLIVXgy
 LxsLuluIEKLFUNb7cmIOD+x2RwtzXyLnzFQiV8vJuel/zlqT8DCPNZmXLg8I8XAN92dwwUW4zTM
 Rjj79R0+vd6EDs6yfuzLXwusyzCtaXfDqL/vWERR0PqnCK/2O7Z1ph0jDP7+Kp+/5At2BMnkucz
 K1nHf3njAPJ52e+B8dw==
X-Proofpoint-GUID: ZjdFL63w9_Oqq-ET4l36EL891eHDly6H
X-Proofpoint-ORIG-GUID: ZjdFL63w9_Oqq-ET4l36EL891eHDly6H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230080

On Fri, Mar 20, 2026 at 05:15:38PM +0100, Claudio Imbrenda wrote:
> The slow path of the fault handler ultimately called gmap_link(), which
> assumed the fault was a major fault, and blindly called dat_link().
> 
> In case of minor faults, things were not always handled properly; in
> particular the prefix and vsie marker bits were ignored.
> 
> Move dat_link() into gmap.c, renaming it accordingly. Once moved, the
> new _gmap_link() function will be able to correctly honour the prefix
> and vsie markers.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: 94fd9b16cc67 ("KVM: s390: KVM page table management functions: lifecycle management")
> Fixes: a2c17f9270cc ("KVM: s390: New gmap code")

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

