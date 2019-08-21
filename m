Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726527AbfHUJ2w (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 21 Aug 2019 05:28:52 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7L9ROKE110578
        for <linux-s390@vger.kernel.org>; Wed, 21 Aug 2019 05:28:51 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uh290u2pt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 21 Aug 2019 05:28:51 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 21 Aug 2019 10:28:48 +0100
Subject: Re: [kvm-unit-tests PATCH 0/3] s390x: More emulation tests
References: <20190820105550.4991-1-frankja@linux.ibm.com>
 <09b66729-1263-381f-9af5-9f68332c5415@redhat.com>
 <35c4aa37-c0c8-4f27-66e0-23145fe48182@linux.ibm.com>
 <6addbd2b-435b-9367-8a13-152b094707ac@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 21 Aug 2019 11:28:45 +0200
MIME-Version: 1.0
In-Reply-To: <6addbd2b-435b-9367-8a13-152b094707ac@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7qH6F8qSQCqrrxCu9OA6ppy3ZqeffagAT"
Message-Id: <6c6fb63c-af8a-ecea-957b-9e5a48edf399@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7qH6F8qSQCqrrxCu9OA6ppy3ZqeffagAT
Content-Type: multipart/mixed; boundary="XPm09mOedldALs5EOtZtOnaj9t24tk4TO";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com
Message-ID: <6c6fb63c-af8a-ecea-957b-9e5a48edf399@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH 0/3] s390x: More emulation tests
References: <20190820105550.4991-1-frankja@linux.ibm.com>
 <09b66729-1263-381f-9af5-9f68332c5415@redhat.com>
 <35c4aa37-c0c8-4f27-66e0-23145fe48182@linux.ibm.com>
 <6addbd2b-435b-9367-8a13-152b094707ac@redhat.com>
In-Reply-To: <6addbd2b-435b-9367-8a13-152b094707ac@redhat.com>

--XPm09mOedldALs5EOtZtOnaj9t24tk4TO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/21/19 10:53 AM, David Hildenbrand wrote:
> On 21.08.19 10:48, Janosch Frank wrote:
>> On 8/20/19 9:04 PM, David Hildenbrand wrote:
>>> On 20.08.19 12:55, Janosch Frank wrote:
>>>> The first patch allows for CECSIM booting via PSW restart.
>>>> The other ones add diag288 and STSI tests.
>>>>
>>>> I chose to start with these since they are low controversy. My queue=

>>>> still contains the sclp patches and a simple smp library with
>>>> tests. They will follow later.
>>>
>>> On which branch do these patches apply? I fail to am 2+3 on master (w=
ell
>>> I didn't try too hard to resolve ;) ). Do you have a branch somewhere=
?
>>>
>>
>> That is currently on top of master (24efc22), the only merge conflicts=

>> might be s390x/Makefile or unittests.conf if your branch is not clean.=

>> I'm trying to get a public github account for that and qemu.
>>
>=20
> t460s: ~/git/kvm-unit-tests master $ git fetch origin
> t460s: ~/git/kvm-unit-tests master $ git reset --hard origin/master
> HEAD is now at 03b1e45 x86: Support environments without test-devices
> t460s: ~/git/kvm-unit-tests master $ git am \[kvm-unit-tests\ PATCH\ *
> Applying: s390x: Support PSW restart boot
> Applying: s390x: Diag288 test
> error: patch failed: s390x/Makefile:11
> error: s390x/Makefile: patch does not apply
> error: patch failed: s390x/unittests.cfg:61
> error: s390x/unittests.cfg: patch does not apply
> Patch failed at 0002 s390x: Diag288 test
> hint: Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".=

>=20
> Are you sure?
>=20


The internal mirror did not pick up the changes of the last few days...


--XPm09mOedldALs5EOtZtOnaj9t24tk4TO--

--7qH6F8qSQCqrrxCu9OA6ppy3ZqeffagAT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl1dDs0ACgkQ41TmuOI4
ufh4hQ/+NC1gfvEtdZamkcJUTvTcCnkrfIMZ70U+Pc0t3L8wWCAtr0ylORLgptoH
MiJ3qpl4XyZ+AnrdyHhuReZjCJcE2I+FR2ORestd0HUvP9FbP1lVsyuVyUWWD7GE
nWFhXXH67JH2SzUe0sc5q7/xNOpM0DcAFTzIdPsYE5Ry2XwxLt94JruSOCUa9cGD
K+qn6KGFNXy8W4w0ben3Isao1D+Y8ZJV+AsoitbWBt8puW0TBAzcdC7MvgRp6WYG
+doRlmCOZceds4++RymAdhEMmv/AH58L6OhBatpRRrHvyrrE2rD/Ez0tF6/tIC/F
DhpKhEb+pwpNewAq2DnNodrcWTTQ92d0Pvf1ylDHNmJcpsJS3VkewtBbNqtKAJn5
VHNnZgTwRn8t3Zv2r62MyiiimWNqW/2aHRXUKTMdsIRhTNdm3OOGG7nMZTlcdSaL
l9eF5NC4DKe82DV+OQLnaGTFreIiT1uRdUREJG0rmZNcK276V6/aLLjHguElenD4
/dUoEMIgtRTmP7h4LiLgYqEWI5F16oD3JIBkNLf+13TomATBbI3eKYhBrNBYwflL
MGaZVqN9ThgWeuOUy9qXN0SyMJHjxwd3CffOM0aTpg1zwq7FiDu4O79CH3dUSVla
honb3LmK/HSoOkoWs0U98D5LO6eLMbnXdn46fIEm1UVZuqhLvzg=
=JOFT
-----END PGP SIGNATURE-----

--7qH6F8qSQCqrrxCu9OA6ppy3ZqeffagAT--
