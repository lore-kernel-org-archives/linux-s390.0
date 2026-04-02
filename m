Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228643EE1D7
	for <linux-s390@vger.kernel.org>; Thu,  2 Apr 2026 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142719; cv=pass; b=JYd5lCQenQSUyGEcNHxmnV2zeIhURuozhz+luJsM+adcegJ6PeBWxEe1Ti9p5AZevmvrfANlARqbiITKxTKnf8VEYSgFQsInG1f42/hxFIApn4m0ysg4eqSv67lTbCQlzIuecaPhLHLHRQH6s/BrAnx3uNDCEmhnoK7u7fzyZE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142719; c=relaxed/simple;
	bh=w+loe5TWlSXN9U6ODJ58b3CvRng0SQKuEDz0GLsUofI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cj+pD4LJBBILe0GOrd/REQz5hd/moP3TH+LQLVTk5ees2dcTLZ4mJvEc8HAOz9JDmBwPx9Q0Cdj+Zsjits+SiUEtsc2vTUo/WejWny6u685mO75a5m8Y7yf6IhE9jY1TIV6IvmwLrBfiUyVroIsgUoQ7xjiWgI8TR8n60xpseDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DzfAkDLN; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DzfAkDLN"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50b6c45781aso752491cf.0
        for <linux-s390@vger.kernel.org>; Thu, 02 Apr 2026 08:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775142717; cv=none;
        d=google.com; s=arc-20240605;
        b=DzRfozxelaWzDWiW/C/bwjE68IvKO4KOIInnWIlAVUjy2kgwU72fR5/bsMoYj5WS2D
         K4wI5kn7c8Ul0S5EWOn+704WJNqX/kt98dQGEuleVXvLv0IVREpEs7vEd2FzfAMjwKfX
         Fqix/Z7ylPty/k7fSlH2EAURW/vfhG4Subx8AKDggqJzoiQFytUl8NlG1P45R3CDEWpj
         zMgiOq8BxKYaNMoeiXcRjKXoaW0pXF2S7jBm07LBiHgQX92fcUB/NNDKVr9bKPtsGnxE
         aT7ck7e2+ukaUCDsBtHhTXjPuJwhaleIDVpF3XB8+62RwzoIMu/dk/7SAtvLMHuLMEAe
         H+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q9DxMkkgytWR9am+1WQeQWH9Iy5mfAjxrdhUB29Lo7Q=;
        fh=9qYhcLMxWENMEcOW3Y0rW+emosLKn1p+433HpCXoEK0=;
        b=SANdYenMFD3tb9VxXSBqjMTTIMuGAIN71wCVnGeg3jSxPA02EgyooZhy95asYWy1hO
         3iLTuCnliHzLqvCyxdB99vV6yiN6nghzrLponCEJV9a4onh0CKGY+cpELv48ZpFyNgh/
         UQ+xkfzLZvO7mGOoS292VqYNDQkDdpPkmFTmuIBF2iuP8MOoR5Wim99xV005UJSFXbfx
         fQzYpuYlKqWcf2J++B7/3kdNzOkfUEt7Jy1rpn/025z9UUJt7egdK4hcNNQ2MHidCsnO
         IBpca0PWhphcXzRpnk9uKoAkBc8npzJ5KF52ZswkCgw+db4aNrG89ixPIfSsbRAFEZ/V
         /weQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775142717; x=1775747517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9DxMkkgytWR9am+1WQeQWH9Iy5mfAjxrdhUB29Lo7Q=;
        b=DzfAkDLNJfbjW8FIAqG4U09cR6ik9V5jcjIvcGQ+97r2HgdVCPsa4PLEHNUU6Jxul0
         Pgp5gTerdDyDf5e5HRQtwr9SEbue+crOGV4MCbP1CkwfMqanLnkbDZchNk+9GS8MkirG
         9OB/sDhKSKWtocpiLulvtVcu+Q+qvdFb9lzg0qxBrQCyQCLm/AdngBaLUkEoT5EqZmaf
         Oub1FeRjW0SDpOGmNVmZFumLk4VId8pjSBe71g8PqXGczOKkuntE8qt4T2nZJK1jy2VQ
         mFQVegl1JZYJE2hk/p8ospgFEH6iSgfMhLpjDvGo6tOG5+zTtj94NMkgRgPIe+c8VsDE
         rGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775142717; x=1775747517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q9DxMkkgytWR9am+1WQeQWH9Iy5mfAjxrdhUB29Lo7Q=;
        b=G0o/TxlaacDMqy2dW+PTHGVhDlAeIY7IcO4B5bWdlDjWha3Q6+HgIW0Qj2VUAjTpmj
         /fNu/dR0pHR4xvdZLQMm1/AZpkjd/YM3tK83ti04FwOK6veSpUdtLNceKJVwmLESBXVh
         KGHnLYBtjJ9Aee7+zpZRj3QqLSwJMhbUfK/jfw8RDpipS2KgQzBV2fvPgH+j2b5V9FuA
         o/ex3SFw7OUvUNLJCntblfKDaHDR87s0muHypdyBc5CpiDYwVjI7KuiIoxzCWup/JXG/
         eLj8RoD2UQETRS9dke17npflJa3Fr6XRgyE/D+1XfwH9Z8Varu2R03fowu5fk7iqmZpE
         khNA==
X-Forwarded-Encrypted: i=1; AJvYcCUzwi5TPrjPDc1nM4SPcSLMcF2OZTAouCxjYBbAO/gCqG7BB3q760/QVEa005nGsRXMJVoPZ6rZHmGr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7DWTk1rUPYUqcBWcVEH+iiGjGt4rCiJP4h9obf7rv91WvYAS7
	J7s4kAxf5jZAfLGMBWbYFU791Etg4CSs4dBTkBdDd/KARJB9tEl4vrZo3Kl0Y7jXfwGD4Hrf1Te
	mqGZRvsLXLw2swFKqKNtjqj59Qn16QdYPupRNCRMo
X-Gm-Gg: ATEYQzydkKjfJEzbVLaMI97xJw9xrI0hhU8KIH/wqK4DkVd/LyzNgsiEvfAkyT7sRfm
	icNcJ4+eyTNBQnOqA6tcZMa8tTStHDvDvCxYqqWY8ypEY7RmnHwCC5nSPQ5KHJFmOrU3yhvKjJu
	VJfiki3PrTqCFWKiLBTVQGddZAeS1Lpfh5HMR4mbvfKedNyKbKJwrdxKXAssF0Xu9x7WU91iW4F
	M59foCdOPbghwe+P9+D8FbssNjXQA+kuLPuhOc6nDL97cS5STjzCjeJaQMDAUVq06yh41+nkE1z
	NDc+5yLNZRN2zaemtJuUcYQx/xvA/yO6riTX6g==
X-Received: by 2002:ac8:6907:0:b0:4ff:cb75:2a22 with SMTP id
 d75a77b69052e-50d504ad8ddmr11393801cf.3.1775142716382; Thu, 02 Apr 2026
 08:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327205457.604224-1-surenb@google.com> <20260327205457.604224-3-surenb@google.com>
 <5d90d998-9b8d-435c-b684-260600311797@lucifer.local> <CAJuCfpE5w8r_6Ss=5ZPrEb1RQOTG6HyY8Pivac=iiyqFRZvD4g@mail.gmail.com>
 <20260331112921.854d4f6cc793dba0972ee9f1@linux-foundation.org>
 <cf6975a6-336a-401b-b122-b9597b5710b7@lucifer.local> <CAJuCfpH2eomYbZ0DzKpkae5DKVF69aRsfXx3HzMfPc6cTT5fTg@mail.gmail.com>
 <495a4331-6575-4eb5-91a5-245ab0ad3637@lucifer.local>
In-Reply-To: <495a4331-6575-4eb5-91a5-245ab0ad3637@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 2 Apr 2026 08:11:44 -0700
X-Gm-Features: AQROBzDDBiQJXBj1ghnJLgm5n9vUtQ0-AtJqWv_KWozRinmr8YW0M_6ikqdSFOA
Message-ID: <CAJuCfpEn53AgKkjLBN2AeaHxxV8vHVj697Cb=Hb-U8LisNztxw@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] mm: use vma_start_write_killable() in mm syscalls
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org, 
	mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 6:19=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kernel=
.org> wrote:
>
> On Tue, Mar 31, 2026 at 01:14:51PM -0700, Suren Baghdasaryan wrote:
> > On Tue, Mar 31, 2026 at 11:47=E2=80=AFAM Lorenzo Stoakes (Oracle)
> > <ljs@kernel.org> wrote:
> > >
> > > On Tue, Mar 31, 2026 at 11:29:21AM -0700, Andrew Morton wrote:
> > > > On Tue, 31 Mar 2026 08:01:11 -0700 Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> > > >
> > > > > > Instead? That is, assuming we really need to care about this at=
 all.
> > > > > >
> > > > > > But I think I don't like this change at all?
> > > > >
> > > > > Yeah, this was the part I wasn't sure if it's worth adding. With =
your
> > > > > vote confirming my scepticism I'll go ahead and remove the parts =
I
> > > > > added to avoid extra vma_start_write_killable() call (3 instances=
 in
> > > > > all) and will post v7.
> > > >
> > > > Thanks.  I'll remove v6 from mm.git and shall await Lorenzo's advic=
e on
> > > > v7.
> > > >
> > >
> > > Ack, if we just drop the problematic bits we might still be fine for =
7.1 :)
> >
> > Let's get your cleanup first and then see where we are. I also hate
> > the way I have to report a fake error code, so with that cleanup the
> > patchset should be much nicer.
>
> Ack, yeah it's horrid, + _my fault_ :)

No worries, I can wait.

>
> I can put something together now perhaps that can potentially be queued u=
p for
> 7.2 at 7.1-rc1.

Thanks! That would be appreciated.

>
> Cheers, Lorenzo
