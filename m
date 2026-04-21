Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9073D6CDA;
	Tue, 21 Apr 2026 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785147; cv=none; b=WsnyrxyL9SKZNbU+Kvns97z+GC+XXf9j03ci/DbTnmXeJOsoFkQMmBQX6eoFI7ruM1J4nSBEWV0aoXfccSwuhZYWnP65SEM9nmS3jplVHZa07wp3EKOf8hs6jk9n9jf5OaTsf7GWw9MctNtQRpBdlwHwT5cyqvw0Qkvjj7LcKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785147; c=relaxed/simple;
	bh=bhjRbszknOQ2TU+0I8/PclKW3pksXK24dd/nc8Fmjmo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=L8JrG9iYIcPwgB25oFiFp+UwiE/seEMNPMzjNtuleJDRuAAYyXeZNma1kVFkCEqPpMUfWtgchxPD+WHECVyTGWj8Af7CtFVM3zngX0+RNLzSq0EPxjirQ9C7R+bGAV21AaLiwqL2KW0M9LZ8QUf8nvLJQQbikoGRNrGbwBByS6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hBD1Dj+f; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hBD1Dj+f"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LDNCKG1926141;
	Tue, 21 Apr 2026 15:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=g7O9/R
	njAuS9ztjkoQG829XGeh6BPLdmKeZz2E5B1oE=; b=hBD1Dj+fWEnwLessBWqZdt
	mRnSB3kVYbC6lx0Iw6Pzh4rjK/5Jz36sUx6/xZoYAU5JhG6ZTJfoQdvVJMkHkdWZ
	gOUt9+33CtU8/cXXEJ6t642d878+UvYHHiL5OGtE1k50m4L/A8eBbAeVs77EWwLA
	GDMCeXIfSnJndthccp//rij0BD4HcIPKeVh6QjHjECVvFrriMi3OKhJf+1F2ZD5+
	4jfmmgt8D2wiZWAAOledBHWZ6PrJwkQo8AaTAa7L4ZFctrjdCzQwSHQn38c9CibG
	+YvtTzo0QJ63Vn8yb12OmHwiVPRkiL+uCM1YOXwzhO9FlGh+y5H1Yfeww1uiSHBQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2nf50xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 15:25:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LFKOY8031159;
	Tue, 21 Apr 2026 15:25:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmmnvsbky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 15:25:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LFPdqd48562652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 15:25:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7FFB2004B;
	Tue, 21 Apr 2026 15:25:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B46320043;
	Tue, 21 Apr 2026 15:25:39 +0000 (GMT)
Received: from darkmoore (unknown [9.52.198.32])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 15:25:39 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 17:25:34 +0200
Message-Id: <DHYXRIE2U99D.MP0YOJ7K6S40@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <nrb@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH v2 3/4] lib: s390x: sie: Memory rework
X-Mailer: aerc 0.21.0
References: <20260420084933.251244-1-frankja@linux.ibm.com>
 <20260420084933.251244-4-frankja@linux.ibm.com>
In-Reply-To: <20260420084933.251244-4-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WyfxJsTkOD6cjuenpGrgIBVsNVWePzE4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE1MyBTYWx0ZWRfX91pULjK9bg17
 bKQ2vdcKVIFVrMZO7URwp8V4I2/TjjIWMTjZtIY/NbiJd9zH8eHBXrPqUFxiKLcLjubezsKgUqP
 wKPwu1ZucVS9MIviFUnVvvU/hy5AfyyLNa4wzGfqYsEAyT3xVdheyBS2f3XUZK7ax8R5/SUhSOd
 nGNj/rxYE3Bgw0UjbOxVBDDpe6OunBA5dBieZ9RB9bw7Oqc3zQ6oudbGXIWVQvG3T46KUsF00Uh
 ONcVOGQSx9IHLiS+DFX7tSlZdUlZkikJQmhCGJ9woMBU2+A3a42V97NKAuNe4D2gnLlhoARNTb1
 jh2sLbdjgmy8g/hSmg6YP4N3Zn4AgUfUiugm8NthyK89SyBlKwY24prKy8eo6lAPj6RaFJYfsVn
 FZJ5BRDptqW3getYPkQ6b/60PzKITwx5CBaOH6JoztBRY4PKAFwQEjzIaELJGzFnXm9RNoejYWO
 /SchMkSv9h2kvFu23LA==
X-Proofpoint-GUID: WyfxJsTkOD6cjuenpGrgIBVsNVWePzE4
X-Authority-Analysis: v=2.4 cv=B7iJFutM c=1 sm=1 tr=0 ts=69e796f8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=evKMgdgJo9mmlCqQVy4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210153

On Mon Apr 20, 2026 at 10:44 AM CEST, Janosch Frank wrote:
> Make sie_guest_create() directly alloc the guest's memory.
>
> Also we never freed the memory that the sie library allocates as the gues=
t
> ram on destruction of the VM. Most tests reuse the VM or just leak the
> memory since the standard allocation is one megabyte and tests only
> use single digit numbers of VMs.
>
> It's time to add automatic freeing to the sie library when a VM is
> destroyed.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

with nit fixed:
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  lib/s390x/sie.c     | 49 ++++++++++++++++++++++++---------------------
>  lib/s390x/sie.h     |  2 +-
>  lib/s390x/snippet.h |  9 +++++----
>  s390x/mvpg-sie.c    |  2 +-
>  s390x/pv-diags.c    |  2 +-
>  s390x/pv-edat1.c    |  5 +----
>  s390x/pv-icptcode.c |  4 ++--
>  s390x/pv-ipl.c      |  2 +-
>  s390x/sie-dat.c     |  2 +-
>  s390x/sie.c         | 13 ++++--------
>  s390x/spec_ex-sie.c |  2 ++
>  s390x/stfle-sie.c   |  2 ++
>  12 files changed, 47 insertions(+), 47 deletions(-)
>
> diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
> index b1b0a8a0..f0e1c41b 100644
> --- a/lib/s390x/sie.c
> +++ b/lib/s390x/sie.c
> @@ -121,29 +121,6 @@ void sie_guest_sca_create(struct vm *vm)
>  	vm->sca->cpu[0].sda =3D (uint64_t)vm->sblk;
>  }
> =20
> -/* Initializes the struct vm members like the SIE control block. */
> -void sie_guest_create(struct vm *vm, uint64_t guest_mem, uint64_t guest_=
mem_len)
> -{
> -	vm->sblk =3D alloc_page();
> -	memset(vm->sblk, 0, PAGE_SIZE);
> -	vm->sblk->cpuflags =3D CPUSTAT_ZARCH | CPUSTAT_RUNNING;
> -	vm->sblk->ihcpu =3D 0xffff;
> -	vm->sblk->prefix =3D 0;
> -
> -	/* Guest memory chunks are always 1MB */
> -	assert(!(guest_mem_len & ~HPAGE_MASK));
> -	vm->guest_mem =3D (uint8_t *)guest_mem;
> -	/* For non-PV guests we re-use the host's ASCE for ease of use */
> -	vm->save_area.guest.asce =3D stctg(1);
> -	/* Currently MSO/MSL is the easiest option */
> -	vm->sblk->mso =3D (uint64_t)guest_mem;
> -	vm->sblk->msl =3D (uint64_t)guest_mem + ((guest_mem_len - 1) & HPAGE_MA=
SK);
> -
> -	/* CRYCB needs to be in the first 2GB */
> -	vm->crycb =3D alloc_pages_flags(0, AREA_DMA31);
> -	vm->sblk->crycbd =3D (uint32_t)(uintptr_t)vm->crycb;
> -}
> -
>  /**
>   * sie_guest_alloc() - Allocate memory for a guest and map it in virtual=
 address
>   * space such that it is properly aligned.
> @@ -185,6 +162,31 @@ uint8_t *sie_guest_alloc(uint64_t guest_size)
>  	return guest_virt;
>  }
> =20
> +/* Initializes the struct vm members like the SIE control block. */
> +void sie_guest_create(struct vm *vm, uint64_t guest_mem_len)
> +{
> +	void *guest_mem =3D sie_guest_alloc(guest_mem_len);
> +
> +	vm->sblk =3D alloc_page();
> +	memset(vm->sblk, 0, PAGE_SIZE);
> +	vm->sblk->cpuflags =3D CPUSTAT_ZARCH | CPUSTAT_RUNNING;
> +	vm->sblk->ihcpu =3D 0xffff;
> +	vm->sblk->prefix =3D 0;
> +
> +	/* Guest memory chunks are always 1MB */
> +	assert(!(guest_mem_len & ~HPAGE_MASK));
> +	vm->guest_mem =3D (uint8_t *)guest_mem;
> +	/* For non-PV guests we re-use the host's ASCE for ease of use */
> +	vm->save_area.guest.asce =3D stctg(1);
> +	/* Currently MSO/MSL is the easiest option */
> +	vm->sblk->mso =3D (uint64_t)guest_mem;
> +	vm->sblk->msl =3D (uint64_t)guest_mem + ((guest_mem_len - 1) & HPAGE_MA=
SK);
> +
> +	/* CRYCB needs to be in the first 2GB */
> +	vm->crycb =3D alloc_pages_flags(0, AREA_DMA31);
> +	vm->sblk->crycbd =3D (uint32_t)(uintptr_t)vm->crycb;
> +}
> +

nit:
This looks like you are moving that unchanged. Is that intended? If it is p=
lease
add to the commit comment that this is moved unchanged at least or dont mov=
e it.

>  /* Frees the memory that was gathered on initialization */
>  void sie_guest_destroy(struct vm *vm)
>  {
> @@ -192,4 +194,5 @@ void sie_guest_destroy(struct vm *vm)
>  	free_page(vm->sblk);
>  	if (vm->sblk->ecb2 & ECB2_ESCA)
>  		free_page(vm->sca);
> +	free_pages((void *)virt_to_pte_phys(get_primary_page_root(), vm->guest_=
mem));
>  }
> diff --git a/lib/s390x/sie.h b/lib/s390x/sie.h
> index 3ec49ed0..85d691d5 100644
> --- a/lib/s390x/sie.h
> +++ b/lib/s390x/sie.h
> @@ -59,7 +59,7 @@ static inline bool sie_is_pv(struct vm *vm)
>  }
> =20
>  void sie_guest_sca_create(struct vm *vm);
> -void sie_guest_create(struct vm *vm, uint64_t guest_mem, uint64_t guest_=
mem_len);
> +void sie_guest_create(struct vm *vm, uint64_t guest_mem_len);
>  void sie_guest_destroy(struct vm *vm);
> =20
>  uint8_t *sie_guest_alloc(uint64_t guest_size);
> diff --git a/lib/s390x/snippet.h b/lib/s390x/snippet.h
> index 910849aa..94688f49 100644
> --- a/lib/s390x/snippet.h
> +++ b/lib/s390x/snippet.h
> @@ -125,11 +125,8 @@ static inline void snippet_pv_init(struct vm *vm, co=
nst char *gbin,
>  /* Allocates and sets up a snippet based guest */
>  static inline void snippet_setup_guest(struct vm *vm, bool is_pv)
>  {
> -	const unsigned long guest_size =3D SZ_1M;
> -	uint8_t *guest_start =3D sie_guest_alloc(guest_size);
> -
>  	/* Initialize the vm struct and allocate control blocks */
> -	sie_guest_create(vm, (uint64_t)guest_start, guest_size);
> +	sie_guest_create(vm, SZ_1M);
> =20
>  	if (is_pv) {
>  		/* FMT4 needs a ESCA */
> @@ -144,4 +141,8 @@ static inline void snippet_setup_guest(struct vm *vm,=
 bool is_pv)
>  	}
>  }
> =20
> +static inline void snippet_destroy_guest(struct vm *vm)
> +{
> +	sie_guest_destroy(vm);
> +}
>  #endif
> diff --git a/s390x/mvpg-sie.c b/s390x/mvpg-sie.c
> index 3050a8bb..21082c53 100644
> --- a/s390x/mvpg-sie.c
> +++ b/s390x/mvpg-sie.c
> @@ -118,7 +118,7 @@ int main(void)
>  	setup_guest();
>  	test_mvpg();
>  	test_mvpg_pei();
> -	sie_guest_destroy(&vm);
> +	snippet_destroy_guest(&vm);
> =20
>  done:
>  	report_prefix_pop();
> diff --git a/s390x/pv-diags.c b/s390x/pv-diags.c
> index 09b83d59..b6f08dd2 100644
> --- a/s390x/pv-diags.c
> +++ b/s390x/pv-diags.c
> @@ -156,7 +156,7 @@ int main(void)
>  	test_diag_yield();
>  	test_diag_288();
>  	test_diag_500();
> -	sie_guest_destroy(&vm);
> +	snippet_destroy_guest(&vm);
> =20
>  done:
>  	report_prefix_pop();
> diff --git a/s390x/pv-edat1.c b/s390x/pv-edat1.c
> index e423f2fc..ff762c75 100644
> --- a/s390x/pv-edat1.c
> +++ b/s390x/pv-edat1.c
> @@ -437,15 +437,12 @@ static bool check_facilities(void)
> =20
>  static void init(void)
>  {
> -	uint8_t *guest_memory;
> -
>  	setup_vm();
> =20
>  	root =3D get_primary_page_root();
>  	ctl_set_bit(0, CTL0_EDAT);
> =20
> -	guest_memory =3D alloc_pages(GUEST_ORDER - PAGE_SHIFT);
> -	sie_guest_create(&vm, (uint64_t)guest_memory, GUEST_SIZE);
> +	sie_guest_create(&vm, GUEST_SIZE);
>  	sie_guest_sca_create(&vm);
>  	uv_init();
>  	uv_setup_asces();
> diff --git a/s390x/pv-icptcode.c b/s390x/pv-icptcode.c
> index 5293306b..bdef3a05 100644
> --- a/s390x/pv-icptcode.c
> +++ b/s390x/pv-icptcode.c
> @@ -164,7 +164,7 @@ static void test_validity_handle_not_in_config(void)
> =20
>  	/* Destroy the second vm, since we don't need it for further tests */
>  	uv_destroy_guest(&vm2);
> -	sie_guest_destroy(&vm2);
> +	snippet_destroy_guest(&vm2);
> =20
>  	uv_destroy_guest(&vm);
>  	report_prefix_pop();
> @@ -368,7 +368,7 @@ int main(void)
>  	test_validity_handle_not_in_config();
>  	test_validity_already_running();
>  	test_validity_timing();
> -	sie_guest_destroy(&vm);
> +	snippet_destroy_guest(&vm);
> =20
>  done:
>  	report_prefix_pop();
> diff --git a/s390x/pv-ipl.c b/s390x/pv-ipl.c
> index 61a1e0c0..1219573f 100644
> --- a/s390x/pv-ipl.c
> +++ b/s390x/pv-ipl.c
> @@ -135,7 +135,7 @@ int main(void)
>  	snippet_setup_guest(&vm, true);
>  	test_diag_308(0);
>  	test_diag_308(1);
> -	sie_guest_destroy(&vm);
> +	snippet_destroy_guest(&vm);
> =20
>  done:
>  	report_prefix_pop();
> diff --git a/s390x/sie-dat.c b/s390x/sie-dat.c
> index e40e348f..a5ff0872 100644
> --- a/s390x/sie-dat.c
> +++ b/s390x/sie-dat.c
> @@ -101,7 +101,7 @@ int main(void)
> =20
>  	setup_guest();
>  	test_sie_dat();
> -	sie_guest_destroy(&vm);
> +	snippet_destroy_guest(&vm);
> =20
>  done:
>  	report_prefix_pop();
> diff --git a/s390x/sie.c b/s390x/sie.c
> index ce5b6069..f08564b1 100644
> --- a/s390x/sie.c
> +++ b/s390x/sie.c
> @@ -20,7 +20,6 @@
>  #include <sclp.h>
>  #include <sie.h>
> =20
> -static u8 *guest;
>  static u8 *guest_instr;
>  static struct vm vm;
> =20
> @@ -70,7 +69,7 @@ static void test_epoch_ext(void)
>  		return;
>  	}
> =20
> -	guest[0] =3D 0x00;
> +	vm.guest_mem[0] =3D 0x00;
>  	memcpy(guest_instr, instr, sizeof(instr));
> =20
>  	vm.sblk->gpsw.addr =3D PAGE_SIZE * 2;
> @@ -82,19 +81,15 @@ static void test_epoch_ext(void)
>  	sie(&vm);
> =20
>  	/* ... should result in the same epoch extension here: */
> -	report(guest[0] =3D=3D 0x47, "epdx: different epoch is visible in the g=
uest");
> +	report(vm.guest_mem[0] =3D=3D 0x47, "epdx: different epoch is visible i=
n the guest");
>  }
> =20
>  static void setup_guest(void)
>  {
> -	setup_vm();
> -
> -	guest =3D sie_guest_alloc(SZ_1M);
> +	sie_guest_create(&vm, HPAGE_SIZE);
> =20
>  	/* The first two pages are the lowcore */
> -	guest_instr =3D guest + PAGE_SIZE * 2;
> -
> -	sie_guest_create(&vm, (uint64_t)guest, HPAGE_SIZE);
> +	guest_instr =3D vm.guest_mem + PAGE_SIZE * 2;
>  }
> =20
>  int main(void)
> diff --git a/s390x/spec_ex-sie.c b/s390x/spec_ex-sie.c
> index fe2f23ee..6ab4144c 100644
> --- a/s390x/spec_ex-sie.c
> +++ b/s390x/spec_ex-sie.c
> @@ -71,6 +71,8 @@ static void test_spec_ex_sie(void)
>  		report_info("%s", msg);
>  	else
>  		report_info("Did not interpret initial exception");
> +
> +	snippet_destroy_guest(&vm);
>  	report_prefix_pop();
>  	report_prefix_pop();
>  }
> diff --git a/s390x/stfle-sie.c b/s390x/stfle-sie.c
> index 21cf8ff8..8df1185c 100644
> --- a/s390x/stfle-sie.c
> +++ b/s390x/stfle-sie.c
> @@ -133,6 +133,8 @@ int main(int argc, char **argv)
>  	setup_guest();
>  	if (run_format_0)
>  		test_stfle_format_0();
> +
> +	snippet_destroy_guest(&vm);
>  out:
>  	return report_summary();
>  }

