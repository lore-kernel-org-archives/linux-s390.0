Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88CB3009F0
	for <linux-s390@vger.kernel.org>; Mon, 18 Aug 2025 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506077; cv=none; b=L+gfsELggRydtXI8U6hLk+PuXyRgzw5jPkq+DdAfN+zTO8ZemgYEFLVhxT6E/sFsvFcvLK3O1jl8yPSKMkgyaTuy7VXIm5YfEU4soVBMo8DEOplW8EfM1/qtabIQRtp9oL8oZE1GimXfVA175ekN2vSQVNlD/g/He+Gd4N7m8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506077; c=relaxed/simple;
	bh=YKnYr324eUUhj+QvrdVq/1e4Gz0w8e7EzwXqGsvWiSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNW4EwrvVMgmnMnMlr2LrjNVwsg59HvbwRf6D/1wPzmvAXmLTMlVcU/6u4NDlCoTR9nIdZ9V9KzhT/FUZzwSvNI9vs3mWPZ/7dQsPOmXF35jjRcoVChCMAxw6KgWO81Of+3Pe/S55dEbgFYEVw/ahG9gv3n2IVnE8SF9fp/pvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Aze4Y5K8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Aze4Y5K8"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7m8HX019836
	for <linux-s390@vger.kernel.org>; Mon, 18 Aug 2025 08:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YKnYr324eUUhj+QvrdVq/1e4Gz0w8e7EzwXqGsvWiSk=; b=Aze4Y5K8XQlzwnRF
	KS2Vkdxd7n2qp5VewK8A0a6hxTVqbzMOozD5we+cTVDCFI/JgzI4KiILotlO/UDT
	5nep91KwnnHHqgiAzY1H8M3CWe1zTEmZYyWHunj4Ox0D6WSd5grZgkLGRwPg1VDC
	AV7KF5nJZeWoctIPiE0ufDcHdCnyV7xMUGfrwbXbmIslahVPylvI9zmR1/9esOJY
	AFEx5vpmQjcRyyhWxPm+CoJZ5aqsnT0c5D/yh/yGTOu1npeEZWylk1LpzGMfAn+L
	zrROeF6fcgqEzADtHMgH4NoIVLArFoA6z69DOF0yue7AxwnGRTjpFvxh/tfVJGe1
	wi1rZg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjc7uxms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 18 Aug 2025 08:34:34 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445805d386so41155895ad.1
        for <linux-s390@vger.kernel.org>; Mon, 18 Aug 2025 01:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506073; x=1756110873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKnYr324eUUhj+QvrdVq/1e4Gz0w8e7EzwXqGsvWiSk=;
        b=wQeE+R4WdXGfsp56ZwqgvShRRGWQUgawgphzWnz2RqXP4Y14KG3EVDfbrOrL75DHzi
         cCrx2NMpWR5MSsE5sKUKp4xpq/IE2rCBy5SEIFV5we3AGdGMh9WehCycglVpg5RApB4b
         6jG0vkivf6YPAO6BlxQrn0sAw9bFcAzuD82iTgdpvVBJx3/neTABbEtLPArwXUbsxCQJ
         odXofpa8A9M4PcDzXSI9fPWMdqHtUIDpVconcSnw48lMixuPiJZ8FaH9jQjKYJfkqDm1
         /GjhfR+3aj8Q0I8Yh8AMbSC3y0pjxZrSv1Ms+WZ77MJLZijgqJDQVQeIkK6UP3d6lOe2
         HLfA==
X-Forwarded-Encrypted: i=1; AJvYcCVCSw5nFO8t5yW42qsLtwijFSIExK8k8O+zVstyGYcRYqMHhUCJQcOsi1Aw3xkIQnbfuudlVGhu27fI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz00H38ftUtMbL9NgnjDu7s6KUgp0oloInL4vE31NlpvKtx33g+
	6JzVFD7ZyfJpO5efWTG8a2fLWz6TEpvcuZ/1heTYyPqvL3Rs37DUMRVg2QAa5w057P/lnGJnTx/
	yqpE3CqcbagfKTNmsHdlx34j6vzcoGZE9I1XM3nAnhmePxFyqDQvWCMWqn33asR8q6KHrWC+BeD
	NbcK9EA72GUrNoE3BmhT29uI+2FC/4VjbDxSxTmLg=
X-Gm-Gg: ASbGncs+GgFs9It1F26bLtbzrh19KECsq4e7+cmdljRqEppq/FC+hNGo8wVnAyGQBYN
	q8q1ZbWHh94WHzgNo50p6gveewtS5yAsEJaadCvMvNMDCgdOu+9vMDQ9muwEYOv/DfWAY8qteRH
	ysGruIb9qhaSJlF0UQr637KA==
X-Received: by 2002:a17:903:b07:b0:23d:fa76:5c3b with SMTP id d9443c01a7336-2446d745130mr162001935ad.22.1755506072924;
        Mon, 18 Aug 2025 01:34:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0iaKkOx5HF+G/2fDa+4Vn+rw7qYZXEvgZcGmIZ96t7UkZ4Y6iVl499qKwZ/lWHVbWQiw75ZkO9MQbjWLb6hM=
X-Received: by 2002:a17:903:b07:b0:23d:fa76:5c3b with SMTP id
 d9443c01a7336-2446d745130mr162001485ad.22.1755506072460; Mon, 18 Aug 2025
 01:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818-numa_memblks-v1-1-9eb29ade560a@oss.qualcomm.com>
 <d7cdb65d-c241-478c-aa01-bc1a5f188e4f@redhat.com> <CALzOmR0C8BFY+-u-_aprVeAhq4uPOQa+f2L5m+yZH+=XZ2cv_w@mail.gmail.com>
 <63082884-1fe2-4740-8e6a-e1d06aa5e239@redhat.com>
In-Reply-To: <63082884-1fe2-4740-8e6a-e1d06aa5e239@redhat.com>
From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 14:04:20 +0530
X-Gm-Features: Ac12FXzX5PzSlv6roYThUOo89xclaREe5qOUHnsYKt7fIrY-t8kJ9YEJL5m2flQ
Message-ID: <CALzOmR0MJv8EgPiFTvvbdkk8H_0BEDA4QQXKyqRPOCwwzGwjsw@mail.gmail.com>
Subject: Re: [PATCH] mm/numa: Rename memory_add_physaddr_to_nid to memory_get_phys_to_nid
To: David Hildenbrand <david@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-acpi@vger.kernel.org, nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-cxl@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfX641R4BVCI5ta
 KbF1m3EJjy3OSE/XTFcZkX/KKNa8teOADCK/h9o/Mj8Sde5Y+8Kxul3mM6LzUkiquPKLawLgcH+
 kYTGpG+9yQZW8ZWmfXgbwnSquZBwzuGgkqMkwj5onQzehU5vnzpXBwUC1oy/+Kc44mnmudBNAPp
 L60C8adm+K8zW5MkvlW36qDElYw0ryW9GoAcTnOYOYBUy06+da1kjajs+scqLA4JqXr4UIt481s
 KmsdGdXybkUjliyu/NJJIXxVUhW+gQX2XJIimDbBxDNwlkQ2lBKM9Q8ICRlhenXct5LGap7SNEk
 mTg1SGNF5YfInfoqXFXWZ8raUPq1VQBLy/3GMPpR3U9fLN/lsQOWMnu8y/2Tp0U7+8FFtI/bBeN
 C5nDF7TR
X-Authority-Analysis: v=2.4 cv=c4mrQQ9l c=1 sm=1 tr=0 ts=68a2e59a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=AFlVVsuRyXfiT6IdkpsA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: J7pKTO_isBKbB0SR0VtjvqF3x09eneIB
X-Proofpoint-ORIG-GUID: J7pKTO_isBKbB0SR0VtjvqF3x09eneIB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160033

On Mon, Aug 18, 2025 at 2:01=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 18.08.25 10:27, Pratyush Brahma wrote:
> > On Mon, Aug 18, 2025 at 12:29=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >> On 18.08.25 08:41, pratyush.brahma@oss.qualcomm.com wrote:
> >>> From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> >>>
> >>> The function `memory_add_physaddr_to_nid` seems a misnomer.
> >>> It does not to "add" a physical address to a NID mapping,
> >>> but rather it gets the NID associated with a given physical address.
> >>
> >> You probably misunderstood what the function is used for: memory hotpl=
ug
> >> aka "memory_add".
> > Thanks for your feedback. I get the part about memory hotplug here but
> > using memory_add still seems a little odd as it doesn't truly reflect
> > what this api is doing.
> > However, I agree that my current suggestion
> > may not be the perfect choice for the name, so I'm open to suggestions.
> >
> > Perhaps, something like "memory_add_get_nid_by_phys" may work here?
>
> I don't think this name is really any better and worth the churn :(
>
Sure. Thanks for taking a look. Will drop this.
> --
> Cheers
>
> David / dhildenb
>
Thanks & Regards
Pratyush
