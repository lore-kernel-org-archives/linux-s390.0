Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46664C433EF
	for <linux-s390@archiver.kernel.org>; Tue,  8 Mar 2022 08:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345019AbiCHIWo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Mar 2022 03:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344955AbiCHIWn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Mar 2022 03:22:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B56C93F33C
        for <linux-s390@vger.kernel.org>; Tue,  8 Mar 2022 00:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646727687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TPGV7ehpSQqx+IAZ6Q4UMs4eKXTc5SZkrFf2pOnvCvw=;
        b=HpCUppJ0sDI2jQPxyzc7qaJveZAnXXbDtl2CoGkcLPW0dmiohWBfivP2J5JxT8fHzJwGUM
        aeLDp9Rx9HLIuQF3w01hChEy1Yxy+AHApwA8IG1nk8rSmEkcFYV6wnrbwbHU/3NYBzsHDA
        KetB3/WwHh3m6Su9DDzqgEv9MtnB2zY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-PmHqg8SvNG2WU983oebhTQ-1; Tue, 08 Mar 2022 03:21:26 -0500
X-MC-Unique: PmHqg8SvNG2WU983oebhTQ-1
Received: by mail-wr1-f70.google.com with SMTP id f9-20020a5d58e9000000b001f0247e5e96so5203519wrd.15
        for <linux-s390@vger.kernel.org>; Tue, 08 Mar 2022 00:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=TPGV7ehpSQqx+IAZ6Q4UMs4eKXTc5SZkrFf2pOnvCvw=;
        b=uraiuzQqVkHl3ZnxR2uDmAm5In8OfRD8cQf2w21VFHKFl/1FMP8FbxdaYyAVwcVV+A
         IRgktEo1WFjzc7drkVkoCPSm8Id8Mb1lkGyYXMz7k31JFUokQEki/Fvxv1oy9S3JTEHY
         z8acgW0CPLS2gOWVo+bnsOnyJwz0xx1zTzMSZv2sn9zClkAc0VXJ2SMECmJNboLfYQ2Q
         uC+aT+InJZttPqdX88sDl+XfW87U/pWgWkh/QSWnaUVZ9mA1ohDPR1QCrswMPgNi0dMJ
         dxFjyEin9ZEBtkWZkpnsu0KYgPgJKf72WL8L4Tb9VYPiAXLmD8vEwDj6rsMsXykghgA/
         A69A==
X-Gm-Message-State: AOAM532iN+i7tq03Ak/uXegc1JoyUtiRzFOTcjkg0r1wKOOnkZTfQfgH
        MKB8RBbEiogfynba6hTPxHFilSA6PMio2ffbrecXX03bcaj+ts5GUbCivKET95WtiMpWkAteX4f
        sBhtXWxYMLV2ZXzm68ImawQ==
X-Received: by 2002:adf:ea4a:0:b0:1f0:6501:80f7 with SMTP id j10-20020adfea4a000000b001f0650180f7mr11022650wrn.306.1646727685400;
        Tue, 08 Mar 2022 00:21:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIWBX20hLFQ6w9ka0x2WIFzYL3vL9HpkUa3WrvCMfxe9qTqYpiU8oGrTjavXY5gqT7TALjPw==
X-Received: by 2002:adf:ea4a:0:b0:1f0:6501:80f7 with SMTP id j10-20020adfea4a000000b001f0650180f7mr11022617wrn.306.1646727684938;
        Tue, 08 Mar 2022 00:21:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:b000:acda:b420:16aa:6b67? (p200300cbc708b000acdab42016aa6b67.dip0.t-ipconnect.de. [2003:cb:c708:b000:acda:b420:16aa:6b67])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm13310899wrr.88.2022.03.08.00.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 00:21:24 -0800 (PST)
Message-ID: <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com>
Date:   Tue, 8 Mar 2022 09:21:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
In-Reply-To: <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 08.03.22 00:18, Linus Torvalds wrote:
> On Mon, Mar 7, 2022 at 2:52 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>>
>> After generic_file_read_iter() returns a short or empty read, we fault
>> in some pages with fault_in_iov_iter_writeable(). This succeeds, but
>> the next call to generic_file_read_iter() returns -EFAULT and we're
>> not making any progress.
> 
> Since this is s390-specific, I get the very strong feeling that the
> 
>   fault_in_iov_iter_writeable ->
>     fault_in_safe_writeable ->
>       __get_user_pages_locked ->
>         __get_user_pages
> 
> path somehow successfully finds the page, despite it not being
> properly accessible in the page tables.

As raised offline already, I suspect

shrink_active_list()
->page_referenced()
 ->page_referenced_one()
  ->ptep_clear_flush_young_notify()
   ->ptep_clear_flush_young()

which results on s390x in:

static inline pte_t pte_mkold(pte_t pte)
{
	pte_val(pte) &= ~_PAGE_YOUNG;
	pte_val(pte) |= _PAGE_INVALID;
	return pte;
}

static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
					    unsigned long addr, pte_t *ptep)
{
	pte_t pte = *ptep;

	pte = ptep_xchg_direct(vma->vm_mm, addr, ptep, pte_mkold(pte));
	return pte_young(pte);
}


_PAGE_INVALID is the actual HW bit, _PAGE_PRESENT is a
pure SW bit. AFAIU, pte_present() still holds:

static inline int pte_present(pte_t pte)
{
	/* Bit pattern: (pte & 0x001) == 0x001 */
	return (pte_val(pte) & _PAGE_PRESENT) != 0;
}


pte_mkyoung() will revert that action:

static inline pte_t pte_mkyoung(pte_t pte)
{
	pte_val(pte) |= _PAGE_YOUNG;
	if (pte_val(pte) & _PAGE_READ)
		pte_val(pte) &= ~_PAGE_INVALID;
	return pte;
}


and pte_modify() will adjust it properly again:

/*
 * The following pte modification functions only work if
 * pte_present() is true. Undefined behaviour if not..
 */
static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
{
	pte_val(pte) &= _PAGE_CHG_MASK;
	pte_val(pte) |= pgprot_val(newprot);
	/*
	 * newprot for PAGE_NONE, PAGE_RO, PAGE_RX, PAGE_RW and PAGE_RWX
	 * has the invalid bit set, clear it again for readable, young pages
	 */
	if ((pte_val(pte) & _PAGE_YOUNG) && (pte_val(pte) & _PAGE_READ))
		pte_val(pte) &= ~_PAGE_INVALID;
	/*
	 * newprot for PAGE_RO, PAGE_RX, PAGE_RW and PAGE_RWX has the page
	 * protection bit set, clear it again for writable, dirty pages
	 */
	if ((pte_val(pte) & _PAGE_DIRTY) && (pte_val(pte) & _PAGE_WRITE))
		pte_val(pte) &= ~_PAGE_PROTECT;
	return pte;
}



Which leaves me wondering if there is a way in GUP whereby
we would lookup that page and not clear _PAGE_INVALID,
resulting in GUP succeeding but faults via the MMU still
faulting on _PAGE_INVALID.


-- 
Thanks,

David / dhildenb

