Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030DC3F7ABB
	for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2026 20:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774988106; cv=pass; b=a3+qYdGNCF3jhyo4mW22GEM1bP/4nT6ypwQm3uS9ppG7znWr0zJjt6ZNospe2FdyjlQLWOwX6wotEtyuw3oV1tE0ezLHV/1d60siY0L+K12/HOs8JPYwti/ktGt+NVpR4XkoEwL1QYuRtEUyA2w73329SRfGa7uVpw8GSJBg6QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774988106; c=relaxed/simple;
	bh=+UtQ9UG0ypfwQxx3wOqbv8WfIkTy4y8DvP/oXcbPF+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRdXIEA3itiBRWBesoWiD2DOEp80KYz6g9JJxTq1GJWqVa9lSJhsid8UYuwv/zjGA5RIIdnBcHOi1rzdO1QJTe8qPDap+Q3ffj1KKilVXbzUTkHFAt1eEGhO3cR8p9C666Casp8YHM4D11MgGBhJrQFXk9TMqxdH9VNNa2+z7+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v0gLwiUo; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v0gLwiUo"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-509062d829dso755721cf.1
        for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2026 13:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774988104; cv=none;
        d=google.com; s=arc-20240605;
        b=BbEFEU9tNcd1XRMBBI/tQb/4zgclJI9gHLHGGQZhIg6WBxuujeh5jqFT0iPAvZyA+u
         EIUon6GTdV88dvi3FGNQTrb3uBEI1YeAPo90Ty1hXJnVLeFXKyJP3fD3Jj1ufd73N8TG
         InbFMh7mC77mnOxRhIz5de/UfUXljeUKhP5XzIhRqda670sSvpDitsA2A4DjcNucvN1Z
         SsmiXEwdtn3pikMZ4jH5mC9W7Mi7dP7/vLPeg0+WZYI+Th9MLRAmjCEYatozGb0V89UI
         Z/ZZBtuMJGqrfj0trQzQ7iwMHLwcOpdw+7HsCp0viqbsVYp3RXP1io2wml8E/6XRiq3M
         4bhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RwVpGG9S8p/uX+u7seQVpxC4moFh4X8htIhQDky5uWk=;
        fh=23bjPqtpBmzhw5JNSVaXDpEMNWg+E8cSRngRcca2FYU=;
        b=N/0sPWUZppp6EMZZOzGkKb7F4mozzLkMzBKNYyWb0phNt68JYlnYgZIxodUrFz0VCF
         7Q+lYxf2usnB91xCNmYGFZjAAldLLzTlA/lCc+cC3IH/belYgxh0TX841jaUs9hjE5jp
         jNTdSzHflbO7RVaiV/rGpEBB1jSt5wwrdSewuxZSgOT+ZyYLSigshk1/2gKXH/jtMzuW
         WrwkmguTIDAFs6zb1F8Rg1LsS/0T+z6v9RQVm1ivsalZhIWJAep4k8b5TNv9oe2SErKu
         N3JutoV5pfxGt+ra7d1wQhw8yFpfPEKBukv9t58NQ7M/kqTQFGzYbBCBMoPGAIN69NKd
         yTug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774988104; x=1775592904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwVpGG9S8p/uX+u7seQVpxC4moFh4X8htIhQDky5uWk=;
        b=v0gLwiUoYlYp0Vy4hhoJjZE8jJjdf/gRmcbwBz0S15B/l6ul3A3tNx77/rzE3gKuiq
         hu3eUy36ejuGZ8UrGEy9BKTYHXHZ8keyfdDiiztwG/P4YTY6AO72qqVr8EbHEcXgK7XT
         lZ982kXPPw7jj+k3+43oi7vqO3LCYKqAR92yDnrEByLzROavkbyDBcxvWMEI5ySnLtGD
         Bvmk99a2T6k8Y/2d8BjnG5LDnmAjDn9Uxq7EWxiD59gY9YUsdiw/fVXAYX2ElXcTbIIq
         Zs+xCvfZYHmk3JZnZel4bk4Gj1AAgkEarFasj9lL5QH2+TiEamLtTJPlxuSou59Sf0yn
         eLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774988104; x=1775592904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RwVpGG9S8p/uX+u7seQVpxC4moFh4X8htIhQDky5uWk=;
        b=Pcmn0J7ru11TvxgKuT5/sIXDRDlyJQ0pDKOwsYjSNYl9/HHYkZWTMz71exjWqth9E0
         6tTOPpRwk7/566yXpSc0ZhfHmVu3WNwNrraDpvFKDS3hnw/bJKvLc/FKKzycrXMc2CAO
         +se5oT+OIGOBRGJ1bsEprVYYnOi/OrN4Xg/peS92Z1Nd3dBEjN7jVVfWx/byeCkCB+Fg
         kvc4gAyhviiGE1xg9PrnkgiSFhS53k34/pFzu9+Tt4zQRmdoUkFaI0s5Mkdpv6ohz34z
         k0j5L8S6ItamoNSgPs0CkhpQ2ecs4BsPyNKgmDr5ahL7xR5dORdYsYDVUkIAcGwZGIGW
         L9fw==
X-Forwarded-Encrypted: i=1; AJvYcCVvgy7PPU3RgjlrjxvHvE+Kgo/qxZzD2DbhEDdL7l6J/uWLkd/X7Q6fx6/d9SLCcKMAQhNuRDNE0XEl@vger.kernel.org
X-Gm-Message-State: AOJu0YyPFL9kmBxovEUbUePGO5RpVf4EubhFUOWVGfkHpMdQLd0shKEg
	yxt+q2nVM2cDKoSW6GwIaU0b+JqWFLDmVkv/yqfJyzd7PAdsq2ZYMdziHc3FLJ9m+HbHD+VX7Md
	/FKKXCP7YkrOcyb7iHFGhtCcEiXeISr3u3YqMHMH6
X-Gm-Gg: ATEYQzy2KOBW6+dIeH9rw2bBQ16ahrVetb9v3Gm/2GveVXiiDWucokvR9SO1wD2tTyO
	n79iaaqwqqvlP87qp3UlNihct5zCurh3zNROJ7jccLrA3UTZHj7XveiGeD7702aeL3iLDTFqRG7
	6UUE1Yg+lVlRFzgf2AZwyKK7rEj7xr/Al658wVbheQArjHPSSUjZartEg2BD2qPtRx++bwJ3I6W
	wsKTBG4fYc9xrr5XZCm9gwH/+kiH92Skk6wxGriBgBXVe9cnRR1BqdnhtvoZ2T3MBW9aQ6Gz/EC
	JlH2GKS2D/6cP2OljmiSN/WAWn3cfpRFcZQTTw==
X-Received: by 2002:a05:622a:a987:10b0:507:35b2:6b9 with SMTP id
 d75a77b69052e-50d3b7cb8ecmr5105641cf.7.1774988103375; Tue, 31 Mar 2026
 13:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327205457.604224-1-surenb@google.com> <20260327205457.604224-3-surenb@google.com>
 <5d90d998-9b8d-435c-b684-260600311797@lucifer.local> <CAJuCfpE5w8r_6Ss=5ZPrEb1RQOTG6HyY8Pivac=iiyqFRZvD4g@mail.gmail.com>
 <20260331112921.854d4f6cc793dba0972ee9f1@linux-foundation.org> <cf6975a6-336a-401b-b122-b9597b5710b7@lucifer.local>
In-Reply-To: <cf6975a6-336a-401b-b122-b9597b5710b7@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 31 Mar 2026 13:14:51 -0700
X-Gm-Features: AQROBzB2U3UmDFrQdi2wX1twdn7twB7j7RYY85tO9ykEBOm_M_3vRiUWXjbFQEo
Message-ID: <CAJuCfpH2eomYbZ0DzKpkae5DKVF69aRsfXx3HzMfPc6cTT5fTg@mail.gmail.com>
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

On Tue, Mar 31, 2026 at 11:47=E2=80=AFAM Lorenzo Stoakes (Oracle)
<ljs@kernel.org> wrote:
>
> On Tue, Mar 31, 2026 at 11:29:21AM -0700, Andrew Morton wrote:
> > On Tue, 31 Mar 2026 08:01:11 -0700 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > > Instead? That is, assuming we really need to care about this at all=
.
> > > >
> > > > But I think I don't like this change at all?
> > >
> > > Yeah, this was the part I wasn't sure if it's worth adding. With your
> > > vote confirming my scepticism I'll go ahead and remove the parts I
> > > added to avoid extra vma_start_write_killable() call (3 instances in
> > > all) and will post v7.
> >
> > Thanks.  I'll remove v6 from mm.git and shall await Lorenzo's advice on
> > v7.
> >
>
> Ack, if we just drop the problematic bits we might still be fine for 7.1 =
:)

Let's get your cleanup first and then see where we are. I also hate
the way I have to report a fake error code, so with that cleanup the
patchset should be much nicer.

>
> Cheers, Lorenzo
