Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199D2226878
	for <linux-s390@vger.kernel.org>; Thu,  6 Feb 2025 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834799; cv=none; b=BTjoA3Cfwm1In4sKDmoRoh8hU9uFS9v3qZ1ZrE16UhAqp10zEM98bll92VXAdAJ7m24sbQ03aIUh7RWyV9KuSSFzlKtnNxUXDQoJHN274holp+YdfbwhXAdap9w7R7z1ZEWwmwo8EO1rvV9LRwfuTLIdwr+zgZsEUeFq4l2aQRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834799; c=relaxed/simple;
	bh=gUOJAR/IhF6W8eDgXv3ClulP9RNWZufA1luYSwdQr9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9cWPCMUKK3hW6z1El0m/gZfyCT0rZreTbBKtEE+BLLwyVAJXM/gpl567b48p1EqFyrB93KmbsbCkzQ5AhcqU0fQg1h3rkkw4pXFP7kBStfj365oc2AmbR5/E8yPPtqo8DSF24lUkaLVUq6wymFXDipKBJHGtSbkepsjP1Tt8IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RUp8/gWS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUp8/gWS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738834797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Slh+3aS/DFBIr8NU6qSeOiy2+t+1bb6Ex5yCMZLyEX0=;
	b=RUp8/gWSE96jvBONMHeOBNkJUZQxpD92c/pqdixrcS9u6s+tbtILIvXuSv5YgchTsBW+9z
	xKbq5h/h7S2AW+h7m3FDFMb543YuzftMsrWqvHJLX578n8N0jc2phgyUwPV95L5TWI0Oqu
	GTw9T02Bq+Yz1q3KZEGE+cqtbvEuoxE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-CDlQul47OjeUB4uPXkae9Q-1; Thu, 06 Feb 2025 04:39:55 -0500
X-MC-Unique: CDlQul47OjeUB4uPXkae9Q-1
X-Mimecast-MFC-AGG-ID: CDlQul47OjeUB4uPXkae9Q
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38dad88c1a0so247025f8f.1
        for <linux-s390@vger.kernel.org>; Thu, 06 Feb 2025 01:39:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834794; x=1739439594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Slh+3aS/DFBIr8NU6qSeOiy2+t+1bb6Ex5yCMZLyEX0=;
        b=GlbHi169UqEvXsvnkboForr5EMeaE6EWGeS8764vgVCZwhcw7gcKCpAtV3oYv9UwVr
         Cnpm9S2bFOWa6fe5enWcodtzGXSS/mgj9usgesOifTLe8BAAqucH7l2slXmW6yf5j2hK
         ISRulaxBOcKr7+zj7So+uzf5NmEhv8gFjHzQnPmlBW28/qYaIviYcU8HBVsfL8B+o0RJ
         EVZe/Snuj/q+/vE2GRdIWXPOZnxyiw3HM5+Sopzra70QMtiAsnyr6dApci7yWuAjjeOp
         JR2tmojhBNDsZU9+OWdUp2Kl8pbLN7jz/wNgpYijo/bmfuC7gt5B8KWtU39Yj55/f0Q0
         Iv1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVb9m00EcZHkE4RDxXejTBg5r/oiGKKB1JEhSM1F5oolpMj0FWUugiue4CncquoxV5z34rXUPw8apkX@vger.kernel.org
X-Gm-Message-State: AOJu0YwLSSc6wBtrXUEYQACEn/QVXibsig0rK1R3+ZyK4Kv6yffgtM8z
	xm+sJeegdP3m2JXHdYQPV83ZjTxbcsBH7cL1dpSnFyMErdbjf41yR0wY0HJsPs2R1W9U1qMvEfb
	vLKpw8qqTmNMNjx3kdvTlSc/voHW5UNJBjEMmRJl36IR0JnMKHgYrWvFAbLs1GTw2fVfnxZxO97
	m5QYaBGLR8LoKwNFaRRB12YA0FCplF9acoPg==
X-Gm-Gg: ASbGncupRu7Oa1k05dTdzdOlatHAL7UdwAcdoPQ166+hgRQwAMpth5iEIvu/iVLexrw
	3xr+dkO4FCd8zHRlrJgJd+6sUDTWH3GYVn8rQz4AOkcowot/CdWnGFTibbvzt
X-Received: by 2002:a5d:6d0f:0:b0:38b:ed7b:f78c with SMTP id ffacd0b85a97d-38db48866e3mr4206906f8f.6.1738834794307;
        Thu, 06 Feb 2025 01:39:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFt1CKO3f+CKE86dCJf9SFD0HAGBkgCM6QuRYHkjTayEXfsiwk+GtsfQLqmG4W1+7DCRz/WrjgtbJiqHvGPn30=
X-Received: by 2002:a5d:6d0f:0:b0:38b:ed7b:f78c with SMTP id
 ffacd0b85a97d-38db48866e3mr4206885f8f.6.1738834793778; Thu, 06 Feb 2025
 01:39:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131112510.48531-1-imbrenda@linux.ibm.com>
In-Reply-To: <20250131112510.48531-1-imbrenda@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Feb 2025 10:39:42 +0100
X-Gm-Features: AWEUYZldEt24bKTnw1J_kYzAkz0ajMtG1oWtCzM4mLYPm5oA4c2iRM_4HgBti8I
Message-ID: <CABgObfb1BztPabrsJcWOOrM7eb6N9FExas-wrCHf4G++6ngEaw@mail.gmail.com>
Subject: Re: [GIT PULL v2 00/20] KVM: s390: some non-trivial fixes and
 cleanups for 6.14
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, 
	borntraeger@de.ibm.com, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 12:25=E2=80=AFPM Claudio Imbrenda
<imbrenda@linux.ibm.com> wrote:
>
> Ciao Paolo,
>
> please pull the following changes:
>
> - some selftest fixes
> - move some kvm-related functions from mm into kvm
> - remove all usage of page->index and page->lru from kvm
> - fixes and cleanups for vsie

Pulled, thanks.

Paolo

>
> and this time I did not forget any Signed-off-by: tags! *facepalm*
> sorry for the noise
>
>
> The following changes since commit 72deda0abee6e705ae71a93f69f55e33be5bca=
5c:
>
>   Merge tag 'soundwire-6.14-rc1' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/vkoul/soundwire (2025-01-29 14:38:19 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-next-6.14-2
>
> for you to fetch changes up to 32239066776a27287837a193b37c6e55259e5c10:
>
>   KVM: s390: selftests: Streamline uc_skey test to issue iske after sske =
(2025-01-31 12:03:53 +0100)
>
> ----------------------------------------------------------------
> - some selftest fixes
> - move some kvm-related functions from mm into kvm
> - remove all usage of page->index and page->lru from kvm
> - fixes and cleanups for vsie
>
> ----------------------------------------------------------------
> Christoph Schlameuss (1):
>       KVM: s390: selftests: Streamline uc_skey test to issue iske after s=
ske
>
> Claudio Imbrenda (14):
>       KVM: s390: wrapper for KVM_BUG
>       KVM: s390: fake memslot for ucontrol VMs
>       KVM: s390: selftests: fix ucontrol memory region test
>       KVM: s390: move pv gmap functions into kvm
>       KVM: s390: use __kvm_faultin_pfn()
>       KVM: s390: get rid of gmap_fault()
>       KVM: s390: get rid of gmap_translate()
>       KVM: s390: move some gmap shadowing functions away from mm/gmap.c
>       KVM: s390: stop using page->index for non-shadow gmaps
>       KVM: s390: stop using lists to keep track of used dat tables
>       KVM: s390: move gmap_shadow_pgt_lookup() into kvm
>       KVM: s390: remove useless page->index usage
>       KVM: s390: move PGSTE softbits
>       KVM: s390: remove the last user of page->index
>
> David Hildenbrand (4):
>       KVM: s390: vsie: fix some corner-cases when grabbing vsie pages
>       KVM: s390: vsie: stop using page->index
>       KVM: s390: vsie: stop messing with page refcount
>       KVM: s390: vsie: stop using "struct page" for vsie page
>
> Sean Christopherson (1):
>       KVM: Do not restrict the size of KVM-internal memory regions
>
>  Documentation/virt/kvm/api.rst                   |   2 +-
>  arch/s390/include/asm/gmap.h                     |  20 +-
>  arch/s390/include/asm/kvm_host.h                 |   6 +-
>  arch/s390/include/asm/pgtable.h                  |  21 +-
>  arch/s390/include/asm/uv.h                       |   6 +-
>  arch/s390/kernel/uv.c                            | 292 +---------
>  arch/s390/kvm/Makefile                           |   2 +-
>  arch/s390/kvm/gaccess.c                          |  44 +-
>  arch/s390/kvm/gmap-vsie.c                        | 142 +++++
>  arch/s390/kvm/gmap.c                             | 212 +++++++
>  arch/s390/kvm/gmap.h                             |  39 ++
>  arch/s390/kvm/intercept.c                        |   7 +-
>  arch/s390/kvm/interrupt.c                        |  19 +-
>  arch/s390/kvm/kvm-s390.c                         | 237 ++++++--
>  arch/s390/kvm/kvm-s390.h                         |  19 +
>  arch/s390/kvm/pv.c                               |  21 +
>  arch/s390/kvm/vsie.c                             | 106 ++--
>  arch/s390/mm/gmap.c                              | 681 +++++------------=
------
>  arch/s390/mm/pgalloc.c                           |   2 -
>  tools/testing/selftests/kvm/s390/ucontrol_test.c |  32 +-
>  virt/kvm/kvm_main.c                              |  10 +-
>  21 files changed, 990 insertions(+), 930 deletions(-)
>  create mode 100644 arch/s390/kvm/gmap-vsie.c
>  create mode 100644 arch/s390/kvm/gmap.c
>  create mode 100644 arch/s390/kvm/gmap.h
>

