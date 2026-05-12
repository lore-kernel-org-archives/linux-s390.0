Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843C0271443
	for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570766; cv=none; b=enjrS/haWMiMLeXoKliizma86HdERSb0avy0Teout1olUhhJUaudwp/rymXCG7Yo//6yM/7KZGGaZ6drErDK+PAFd9I67emLbpku4xceY6FfeMUcT+LW+PTMLB6eQVDclGc6ct5YP9oYOIpeeidba1vQwFfci6UMzx5m48WLbpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570766; c=relaxed/simple;
	bh=7d/sEo+32sz5GCjUloCiZ/npZlGByKeO3RCzAlKI9hM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bQ7CYSm8WRY228cyXva2X8x2ou3OkOgo8UQU9XdrmGJaEuHdoH9l2NgktVzIP2KwjVnzDyolBluLXuFmJImvBfxy0eKdFsnOL+X7Tso1skeYsib/iUx5ZJfmIUDIz1z9CT9AecPtyTcNPBBsBV/Y38ECpiOxzPqxNS7qJOd1p3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CernQuon; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CernQuon"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778570747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KleV71sGLoSIpfimzX+Um4L/dQ6PAAx/tc+TAvzuzrM=;
	b=CernQuonrtrcVA2MC7fNDHHIbGhU1HcTungbtLCMIta9xw0yA8bkoeWkccIPdG6zmIQasQ
	tPlnFy9nQDmaZdx1tKxz4rVtOdNjCmHJN5pHH0kzenPKlNp2X88jet4kLFchRad51zy88b
	1FcHh3iaOY76S3uX79+iVXurv5RUGPs=
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] drivers/base/memory: make memory block get/put explicit
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <943c5cd9-0796-45f5-9f8d-cb7e44457961@linux.ibm.com>
Date: Tue, 12 May 2026 15:25:14 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-mm@kvack.org,
 driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ACADAE38-650D-43D6-8000-891B59850499@linux.dev>
References: <20260511111800.2181785-1-songmuchun@bytedance.com>
 <943c5cd9-0796-45f5-9f8d-cb7e44457961@linux.ibm.com>
To: Donet Tom <donettom@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT



> On May 12, 2026, at 14:52, Donet Tom <donettom@linux.ibm.com> wrote:
>=20
> On 5/11/26 4:48 PM, Muchun Song wrote:
>=20
>> Rename the memory block lookup helper to make the acquired reference
>> explicit, add memory_block_put() to wrap put_device(), and collapse =
the
>> redundant section-number wrapper into a single block-id based lookup
>> interface.
>>=20
>> This makes it clearer to callers that a successful lookup holds a
>> reference that must be dropped, reducing the chance of forgetting the
>> matching put and leaking the memory block device reference.
>>=20
>> Link: =
https://lore.kernel.org/linux-mm/7887915D-E598-42B3-9AFE-BFFBACE8DE2D@linu=
x.dev/#t
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>  .../platforms/pseries/hotplug-memory.c        | 14 ++-----
>>  drivers/base/memory.c                         | 38 =
+++++++------------
>>  drivers/base/node.c                           |  4 +-
>>  drivers/s390/char/sclp_mem.c                  | 17 ++++-----
>>  include/linux/memory.h                        |  7 +++-
>>  mm/memory_hotplug.c                           |  5 +--
>>  6 files changed, 35 insertions(+), 50 deletions(-)
>=20
>=20
>=20
> Hi
>=20
> I did some basic DLPAR memory add/remove tests on PowerPC with this =
patch, and it is working fine.
>=20
> Initial memory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> []# cat /proc/meminfo |grep -i MemTotal
> MemTotal:       205169920 kB
>=20
> After Add
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> []# cat /proc/meminfo |grep -i MemTotal
> MemTotal:       247112960 kB
>=20
> After Remove
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> []# cat /proc/meminfo |grep -i MemTotal
> MemTotal:       173729024 kB
> []#
>=20
> Tested-by: Donet Tom <donettom@linux.ibm.com>


Really thanks for your testing.

Thanks,
Muchun.=
