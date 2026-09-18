Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29874523783
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763502; cv=pass; b=IoEDGq5FnJrAqxq29aDSyQXxDbirw7HG+fxnwv1mfaQjWmurQkdgUeaX0+YDSVvFywzPi2Wb7twNJlZk+aJRN+/7wAq9hyvMonSiNCVKhy10ICSfCnUT87gMfTot05Mhg+FeO7JOZJiumKqQS/9wklUADy1K3udzkkYQyX9Q28g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763502; c=relaxed/simple;
	bh=B8p7ihCHzGvnzup/C6y6XYLlWrQRIq7YUbOlQS6xj3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRJP6ASIyaGwJt7u9mOUfiW81lYtsCE6GVaJEH1Ez2rvm2R1B/n67XfcHNLKdWSybiWJf0riyzcWUk406/xEwUAUKNfVjhXFhrt7Iufexc80JoawY20Z74mj1Do5Qlofb/DJZzx9vab+PUsv1y/4JDZBHC2wLejlOvpzAS5RYKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UU0wjojH; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UU0wjojH"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-530f6bcc301so55081cf.0
        for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 13:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789763498; cv=none;
        d=google.com; s=arc-20260327;
        b=jy/+cBr9GhKWR/HzRm1FCBGv52CHHje9lZzhdhXu9V3C7Bvr3hlDeivPBLwe/eBJDZ
         3nYWpnGK78OTpEWg7V+CJTx1JNJHymcq6lT9JRwUg9Ls88M8Jvc3dC8R6b67GHAYcd6a
         6pld4PWnAgGus17pYYLQbs1FS9mpxsUUN4KDTB05FtNcAQp0tfrlLk6oe70/+1x6JyyW
         FwjT5S4jkRqjemQq5wj/fdtI8gKZ57Y2nrRRW/+vI1JFGxV478R0xQQv+cfn9C+H+RAm
         7ieyWcQsP0QvgAgTmwwZ6Pj8Ipvwxd850vcYuDz81CoXxVz1+R8gC0624lxw6iYnl72Y
         4g4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rakr0DVeS6w19WPN+xiAqZEbcFGWWdpHaQBH8HXSGgc=;
        fh=9XQBbZlJ7OklzaD4S3VnQxz7tAB70ehBfoU/iGCTzlo=;
        b=ZCgDgT+zu3CM628QiThGwjd/bqV7ApRUW7PM1MT+jvUHUK5ClWJBtbM9VfnlbobLGj
         N303GJrG9O3TI6v+qD7UgoVCuX+VW2CFqJImtWcoAP0yEMM5mVM8+/bNj86P8qD5dMrs
         hAwsfewUE0NIOKiJBtYh9ROSZhaEYMmedd+0eEjV58m+6468//HrTSw8AUc2gnvLecKh
         VG/bb6ZwJWSA4okx89HvLEz9P1EYBQA4IklIFRxZ85y/wOKDKAUmtb71F9N43xhOHJGw
         I2F5FvrvZrM5UJ26FI1sr7a59tL1S/EdUBnKLg+5WXqUm0RpvqaFlxF5RggfmK+ckji+
         ieeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789763498; x=1790368298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rakr0DVeS6w19WPN+xiAqZEbcFGWWdpHaQBH8HXSGgc=;
        b=UU0wjojHMZJdEefbV+oe7n3/1SeoG/dOO8hNK7Tj8QvphQy34bQ/TtZfJPFMbLM7Dz
         Y/YVWKsh9GRn1f4QL5Y0tAv574p+Z233A80/H7Il2x+C3qiCdyydEpXhoIeUomNkSzt1
         u26uedB4a+lTAzO3+lsk9SL/2xRHXFuNtkCjCNLqhT5/eS3sAp8P6KWPemR4yNW03+/t
         Y8eKGMCmYLtIa9slPbZ5/d3cujTWZUj7oR6ZaFLAEvvN8VjRm9Zsvsy20ZCKhB4uDz4q
         NgoOUOU2qI60k2fnz6n/kBaIH6Wtw6G2RqENciuFm00/6+5swPRTI5zkRENNInuJF/fH
         XfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789763498; x=1790368298;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rakr0DVeS6w19WPN+xiAqZEbcFGWWdpHaQBH8HXSGgc=;
        b=kiEmDF1w206UPc6nOkENCQ8xDJHCSOvw5H6uoGEiNKDilJmqTXKKyFWTRndnwuXdym
         GNTveRfQLb1bWSfxqa09FyVGfGEULjDr+3kqJ+pysEmRetqwxU965awL2sGPSLlDN1Vl
         VLqKW6HjKH08xwsuSFOr1qEPAAsNRRaEylMx887EMaVi8vxtutHElqdjD49f9qs9WlOd
         nyqMV9mLtUAaAFUxE/nPmcykY+CVGocRMP8CvUyGalAHGjnrpfK2BxRmYHGMCqkL0XNP
         qkWouBT48KvezToMDxhL/3QG1tPg9tZhJyGGU2cOWfxjNnxFhMiUjSQozCOkXgCiYpqG
         WADQ==
X-Forwarded-Encrypted: i=1; AKwUvByb5giYz4Ey0DnP509R9S1liU2IBlH+qmYYntplvvVZ/Z0lq5YbmHmqQSKbOn6RhIa0LQ+YHrlMKav6@vger.kernel.org
X-Gm-Message-State: AFuF++kuJ0F+pB1bIwcnyqsEwEQ0G1c0PYfG2Ka1tYis7peA5WBayFB9
	z9kw4WfHtT2cbffLAAgX4sTbnEOB+vY7M5g51JZ/+obirSMPGfIdFxeUK+0rf/Ng7WlUm7o9RtX
	GcwpVPVj2lis8MEWr2yT6FIPDz7ORsI6eMT5hbFJ2
X-Gm-Gg: AYBFou19AbbUodnt2QF9rVh1Rt+XrMgOS0rbaIwbCQd1fkDqv6BmWNpsF3ehk7vIewG
	4foQQVpk2d7hySTd2P3AYbvsFkLj00C60yf4UmvKz0bBd8UeFEYq448aGTkLiwqXSk61VWQLGOp
	dVN8cgJEan6OWGp1UaeITc7wJuE0B2G+h8VLAs80VaplIKiecy2fKPJYIxfnNldWf/Hj79Ca2G1
	W2mukm4xjxVPLFqBWx9qHcnHxWb3f6M13ZCpsEw48scdsgtsoUvNxB58yUod61sD5MPCKa6l4bt
	GZ3pw8wAmKl2/yG0kypMd47PExfio6Y6VADA8d9Tcv3I+wvnfuN6PA==
X-Received: by 2002:ac8:5d08:0:b0:530:2f98:cebb with SMTP id
 d75a77b69052e-532b099561dmr605641cf.11.1789763497212; Fri, 18 Sep 2026
 13:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914180811.057cba8fcc48d6e0b53a2683@linux-foundation.org> <0b064fe6-ddb3-4f26-a1f2-2e9dd88d590f@kernel.org>
In-Reply-To: <0b064fe6-ddb3-4f26-a1f2-2e9dd88d590f@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 18 Sep 2026 13:31:24 -0700
X-Gm-Features: AcwNN1VqLTR47MatnNlBWbpWA8EMmoQNGykspJvqoxdaovPnF0EYfRCWZF-8zh0
Message-ID: <CAJuCfpFBichJH4OcmSHTb1rOuQBT6k5pXeua9_KgpWjDBKvsYw@mail.gmail.com>
Subject: Re: [PATCH v2 00/40] mm: make VMA flag semantics explicit, eliminate VM_SPECIAL
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 1:21=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/15/26 03:08, Andrew Morton wrote:
> > On Mon, 14 Sep 2026 15:57:20 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.=
org> wrote:
> >
> >> The VM_SPECIAL / VMA_SPECIAL_FLAGS mask conflates several unrelated
> >> properties:
> >>
> >> ...
> >>
> >> It's all rather a mess.
> >>
> >> This series brings some order to things by both limiting what drivers =
can
> >> do with VMA flags and switching to using predicates that describe
> >> behaviour, not arbitrary flags.
> >
> > That's a lot of patches.
> >
> > Review is thin and I expect this won't improve a lot.  Lots of "no
> > functional changes" changes.
>
> I'll expect to go through all of them. Might just take a bit ;)

ditto

>
> --
> Cheers,
>
> David
