Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794850650;
	b=YQNX/AeVDMVbBH2HCbWgXTOPlesbatrYbnQyeAG2Xy6rSUmGHiLT4Zf1jzklA+xRVtN8
	 PEUZCsHFziWSMsUoNwk50skPmuJNdJ7Z4fVRMAOylJ9D+UuYYHGUuxwGwAb91x23zX5uK
	 QGiYchDLJyGIIg7bsdNCj09mnniwoJqv1XNw8Lwsp6jYn9pFnnVBPobutcl7ZiDUzvSfv
	 Up5BJeqiubPV3O5LRos+Ozm3eRg6RdJQoq9kQXiCHRgl5nJYeuu25qvhW0lg1xfQiB3bc
	 QFlf10ZpntxGjhcutFe4tuYAguWB8la2yFG9zekGSZ4mXzsDt661FZQuu5R13pb9NnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
	b=PGifp3g+MSBRbnPLCOuR39x0cS+3F6DtLrstb9pZr+dAF5LSq65Ah317M6MK/FIvSKpa
	 sz0QMaNzWGkB277wheFRsv79bp5q3XrXFPFzne9zro3wUQ6N++AGlJGoJPWwOj0i/F0Cw
	 yhJ6Sgw/LTD224KRnzxtxVVq/555duF4JZnUPZWVtapqQJmX7WsY/PfreWz4Ws4/0ZDQh
	 kGJcpu4xoMuFOZ6pfjiGWjc9qK922ewj8isWlJuBVNMbrD+1GPUcHku9xLGjw1/0TkYiG
	 8k4SY42Y89aTZXM59EO44D3uPEroqOVeG8md3d3GNitrrTmft6+THH/Y535x4zTmwPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wda5m4T+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4556C606A888
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 17:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4556C606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wda5m4T+
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b70192ebceso151584a12.0
        for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 09:37:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794850648; cv=none;
        d=google.com; s=arc-20260327;
        b=DD4wpuVICkP33N6s8XOhDl6tnwOnj2uEmOM6L+j811qPGCNAsM4Td2lZMoGPorTnAB
         0rp+AaK9Io18NdWyK1ERmF+VhsQyUgM8uVBQZ7Nv+llIWRwt5GvCPgC/FMdHYz7ZFo7Q
         QDBkxEFwbrhU84dRr0+W2PIGZ6AAv1ay/U0cHqSwOn1NLtTUdnDG721OO0+ohgazej7e
         lxjT3Ndr6CTu3GW+F1Wb+RCcAWe45/I/cB1STj0ytOczK+fWBaW4/6zDH78E8ry6YcEt
         NgctvxdCDfbctRZGDbTxASzjDkkHEUqTFeyEAdpXoVJu4QSo0MZ49L5MQjyC0XQJosqF
         rM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        fh=g/JILnkjILSeQjZ5/goRSJxS3T/8HEpOQifeC6ovuWA=;
        b=BemkoT/5sAzEBnkBo2FnHzvsNk4/gZm7g6kFODlyc02m6fx8ngO3E30PlvxLTguWzj
         uygFIDYI1mcXKRzHMGRwsbximYDBQK5wImyWeaDcULHz8t0IgaT94TQYn80ZXW/0Nbqc
         GZVM4TcXn+0lunieGKbDVTmE+mkdNWdyiCkG3cSkGxsAI474EDGeNKbrOWP0vW4O+QIw
         30HSBQ8s617EjsPQwKLuErGZI2wkY8i01UITaGAp9WTSSxTFdOqvGFuhoWtCfmip4ePe
         yLHjaTcJZ1uyeOTqVz3ug5vmuNT5sO2qoIP4P7DSME2YV65Dv5bQ2qEacNZrEzfwKb7S
         uaIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794850648; x=1795455448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        b=Wda5m4T+Og74YNLartpajMnAcctT7hnb5haqi9hjLlBRa67TYcEPjf80gw45qsgIx7
         FMobW/aC2ZXQsUmoaLilVLeaESS9ODytholTX6ZkGdI39Z50BqAMQuVm0upEGdU/eTIl
         KzXBiwaEJY7eqa6p49n+ZePGE0YUDeVtz78JPQJb7w7ae3zRsyAfYOAEtJq8eS6befDe
         ANfoXo4rOnrr9cTK5CEQbvEa19yD1CMimOfBL7pxwr0U+pGpN6RB970vgsC2xV+kB6BG
         DqloDFELm5xz1LM2zdKvbUwHIwogDmvmrNVDo81Was00uh+K9TR8cjrFQWZvFUjBWrt9
         3Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794850648; x=1795455448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        b=ttVsyBWu2t2axtU98hesgckRY3fFCyNqM/GWb1aiFdAneIavSvLj3FNYkNsuBegvg6
         b5meCJ88Wi3SBcBFMR5S+Gv9ckhwFUb3Zn9TgFr3wo+Uo5eOSPbtZ/m4FZVm/CQJ+oDc
         8uRTmsI/eVsrSjmo4z1jTuk5nznAmGqrLSkGpcdPknvv1DJOYk+OLsNWC6QGbz3jOSvk
         DyPXY9BeRO9hagK6O4nHMpslK0hn0UGkPPLlvmuCqCHfH+uw0jfF75vMLJF4aaarGEQI
         p+SA3LZeaQR/EZ3M/jNipV58ze0dqvrcDol0moYUWDmSjz3Mbqb02zx8QARO2ItSMk23
         hkdw==
X-Forwarded-Encrypted: i=1; AL+hErHlD0uVYanC7R5UCtxPKMuEFXua7n2YJXsbnnU7aC90eR905meEpjTF09BzQw7LGqcoglN4Je8kfSsy@vger.kernel.org
X-Gm-Message-State: APuU4Z8L7p6VOkyAmseazYxzg+XVHy9t5gNZuYz3RtvbjHZ2EdFyjmWy
	qmINi1yaR5OKvVN67uLs9bYyZWUKv932ydBemBvA4+PFRVg4VWwu8ug8evfsZ/6dtNk6WGJLB7d
	fmmOFF8VhC9ssly4APToMuE3aS4ZqG6I=
X-Gm-Gg: AYBFou2yrF7HUNjDfSXCg3Lwn+rRcfK7tbjovhGX8+PmFAbVJVdDCkIk53MSDaqlkWz
	zPJG71EGosnGd1dY3aoSIaCFfxvEZ8zbvGYP+JFnXu7QD7PYJOyY+9Gf7cBXTPPN5DSgPE1rSNF
	vbb3jU1geuRfC1Oy9Z/BzhtZuV21+Ft2e3mmJTP6xuvbWMKauffJkKF2Vm87Z8lu4sDOktqvKVk
	tvRM5ptkzolfcvuc0wRoYk3z731CfrHFhB/zkau4McBlGnZDzG4mkGu7PnQymI6DBuf2vW3J8Kn
	DhvLw6yij2RtAi+0QGlOmAtBdhPRg/JX5BzY20KVM33TsK87Npc3N87z4zrWo8AG6bWx7xkx4F5
	q5xErdQTqCLS5YAaqt5LTMynIZQcWZTJlVa2UawsNnlrATLrmMP1deyHe8+3cylhhHiO9jg==
X-Received: by 2002:a05:6402:1598:b0:6b5:7250:d621 with SMTP id
 4fb4d7f45d1cf-6b859ae1a00mr134291a12.15.1794850647426; Mon, 16 Nov 2026
 09:37:27 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-33-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-33-8cbbea1cf34f@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Nov 2026 18:37:16 +0100
X-Gm-Features: AclHuK_sKnxFPAK3k65pZhjyZC94SJD4eZ9z2j_P12s3kyb9TMw6hurQcjyq55Q
Message-ID: <CAOQ4uxgPerkkG4ie0SyHVXaBD9VZN2wYfQpEAEi4hytn=ara3A@mail.gmail.com>
Subject: Re: [PATCH RFC v3 33/44] ovl: refuse data-only layers on pseudo filesystems
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 12:10=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> The data of a metacopy file can live in a data-only layer. overlayfs
> doesn't look that data up when it looks up the file. It only remembers
> the absolute redirect and looks up the data lazily the first time
> someone needs it. So until then nothing can tell which filesystem holds
> the data of such a file.
>
> But a data-only layer has no business being a pseudo filesystem in the
> first place. All it does is hold the data of metacopy files and the
> regular files of a pseudo filesystem are kernel interfaces, not storage.
> So let's refuse data-only layers on superblocks with SB_I_PSEUDO at
> mount time.
>
> Data-only layers can be added via the "::" separator in "lowerdir=3D" and
> via "datadir+" by path or by file descriptor. All of them end up at the
> end of ctx->lower. So a single check in ovl_get_lowerstack() covers all
> of them.
>
> Note that regular lower layers on pseudo filesystems are left alone.
> Stacking overlayfs on top of sysfs keeps working.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/overlayfs/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 39d4d57dec230..719c2569dfeaf 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1237,6 +1237,14 @@ static struct ovl_entry *ovl_get_lowerstack(struct=
 super_block *sb,
>         for (i =3D 0; i < ctx->nr; i++) {
>                 l =3D &ctx->lower[i];
>
> +               /* Pseudo filesystems don't hold data for metacopy files.=
 */
> +               if (i >=3D ctx->nr - ctx->nr_data &&
> +                   (l->path.dentry->d_sb->s_iflags & SB_I_PSEUDO)) {
> +                       pr_err("filesystem on %s not supported as data-on=
ly layer\n",
> +                              l->name);
> +                       return ERR_PTR(-EINVAL);
> +               }
> +

How about we make this just a tad more restrictive:

                /* Pseudo filesystems don't belong in composefs setup */
                if (ctx->nr_data &&
                    (l->path.dentry->d_sb->s_iflags & SB_I_PSEUDO)) {
                        pr_err("filesystem on %s not supported along
with data-only layers\n",
                               l->name);
                        return ERR_PTR(-EINVAL);
                }

I could send this as followup patch, but since this version is simpler
there is no real reason to have the intermediate "only ban datadir" step.

Only the commit message needs a little more flexing to justify this.

Thanks,
Amir.
