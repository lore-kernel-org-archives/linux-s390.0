From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Mon, 16 Nov 2015 08:42:33 +0000
Message-ID: <1447663353.145626.46.camel@infradead.org>
References: <20151102144427.GA2876@suse.de>
	 <20151102173218.GC12484@shamir-ThinkPad-T430>
	 <20151105134206.GD2255@suse.de>
	 <20151105.161121.188431695871972310.davem@davemloft.net>
	 <20151107150642.GA4405@shamir-ThinkPad-T430>
	 <CAN+hb0UvztgwNuAh93XdJEe7vgiZgNMc9mHNziHpEopg8Oi4Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="sha-1"; protocol="application/x-pkcs7-signature";
	boundary="=-yseYhWKdhoizDYIVI0ws"
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <CAN+hb0UvztgwNuAh93XdJEe7vgiZgNMc9mHNziHpEopg8Oi4Mg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Benjamin Serebrin <serebrin@google.com>, Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc: David Miller <davem@davemloft.net>, Joerg Roedel <jroedel@suse.de>, benh@kernel.crashing.org, arnd@arndb.de, corbet@lwn.net, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, luto@kernel.org, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, sebott@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>, hch@lst.de, kvm@vger.kernel.org, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


--=-yseYhWKdhoizDYIVI0ws
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2015-11-15 at 22:54 -0800, Benjamin Serebrin wrote:
> We looked into Intel IOMMU performance a while ago and learned a few
> useful things.=C2=A0 We generally did a parallel 200 thread TCP_RR test,
> as this churns through mappings quickly and uses all available cores.
>=20
> First, the main bottleneck was software performance[1].

For the Intel IOMMU, *all* we need to do is put a PTE in place. For
real hardware (i.e not an IOMMU emulated by qemu for a VM), we don't
need to do an IOTLB flush. It's a single 64-bit write of the PTE.

All else is software overhead.

(I'm deliberately ignoring the stupid chipsets where DMA page tables
aren't cache coherent and we need a clflush too. They make me too sad.)


> =C2=A0 This study preceded the recent patch to break the locks into pools
> ("Break up monolithic iommu table/lock into finer graularity pools
> and lock").=C2=A0 There were several points of lock contention:
> - the RB tree ...
> - the RB tree ...
> - the RB tree ...
>=20
> Omer's paper (https://www.usenix.org/system/files/conference/atc15/at
> c15-paper-peleg.pdf) has some promising approaches.=C2=A0 The magazine
> avoids the RB tree issue. =C2=A0

I'm thinking of ditching the RB tree altogether and switching to the
allocator in lib/iommu-common.c (and thus getting the benefit of the
finer granularity pools).

> I'm interested in seeing if the dynamic 1:1 with a mostly-lock-free
> page table cleanup algorithm could do well.

When you say 'dynamic 1:1 mapping', is that the same thing that's been
suggested elsewhere =E2=80=94 avoiding the IOVA allocator completely by usi=
ng a
virtual address which *matches* the physical address, if that virtual
address is available? Simply cmpxchg on the PTE itself, and if it was
already set *then* we fall back to the allocator, obviously configured
to allocate from a range *higher* than the available physical memory.

J=C3=B6rg has been looking at this too, and was even trying to find space i=
n
the PTE for a use count so a given page could be in more than one
mapping before we call back to the IOVA allocator.


> There are correctness fixes and optimizations left in the
> invalidation path: I want strict-ish semantics (a page doesn't go
> back into the freelist until the last IOTLB/IOMMU TLB entry is
> invalidated) with good performance, and that seems to imply that an
> additional page reference should be gotten at dma_map time and put
> back at the completion of the IOMMU flush routine. =C2=A0(This is worthy
> of much discussion.) =C2=A0

We already do something like this for page table pages which are freed
by an unmap, FWIW.

> Additionally, we can find ways to optimize the flush routine by
> realizing that if we have frequent maps and unmaps, it may be because
> the device creates and destroys buffers a lot; these kind of
> workloads use an IOVA for one event and then never come back.=C2=A0 Maybe
> TLBs don't do much good and we could just flush the entire IOMMU TLB
> [and ATS cache] for that BDF.

That would be a very interesting thing to look at. Although it would be
nice if we had a better way to measure the performance impact of IOTLB
misses =E2=80=94 currently we don't have a lot of visibility at all.

> 1: We verified that the IOMMU costs are almost entirely software
> overheads by forcing software 1:1 mode, where we create page tables
> for all physical addresses.=C2=A0 We tested using leaf nodes of size 4KB,
> of 2MB, and of 1GB.=C2=A0 In call cases, there is zero runtime maintenanc=
e
> of the page tables, and no IOMMU invalidations.=C2=A0 We did piles of DMA
> maximizing x16 PCIe bandwidth on multiple lanes, to random DRAM
> addresses.=C2=A0 At 4KB page size, we could see some bandwidth slowdown,
> but at 2MB and 1GB, there was < 1% performance loss as compared with
> IOMMU off.

Was this with ATS on or off? With ATS, the cost of the page walk can be
amortised in some cases =E2=80=94 you can look up the physical address *bef=
ore*
you are ready to actually start the DMA to it, and don't take that
latency at the time you're actually moving the data.

--=20
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation


--=-yseYhWKdhoizDYIVI0ws
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIISjjCCBicw
ggUPoAMCAQICAw3vNzANBgkqhkiG9w0BAQUFADCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcx
ODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENB
MB4XDTE1MDUwNTA5NDM0MVoXDTE2MDUwNTA5NTMzNlowQjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFk
ZWFkLm9yZzEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMkbm9kPbx1j/X4RVyf/pPKSYwelcco69TvnQQbKM8m8xkWjXJI1
jpJ1jMaGUZGFToINMSZi7lZawUozudWbXSKy1SikENSTJHffsdRAIlsp+hR8vWvjsKUry6sEdqPG
doa5RY7+N4WRusWZDYW/RRWE6i9EL9qV86CVPYqw22UBOUw4/j/HVGCV6TSB8yE5iEwhk/hUuzRr
FZm1MJMR7mCS7BCR8Lr5jFY61lWpBiXNXIxLZCvDc26KR5L5tYX43iUVO3fzES1GRVoYnxxk2tmz
fcsZG5vK+Trc9L8OZJfkYrEHH3+Iw41MQ0w/djVtYr1+HYldx0QmYXAtnhIj+UMCAwEAAaOCAtkw
ggLVMAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcD
BDAdBgNVHQ4EFgQUszC96C3w5/2+d+atSr0IpT26YI4wHwYDVR0jBBgwFoAUU3Ltkpzg2ssBXHx+
ljVO8tS4UYIwHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzCCAUwGA1UdIASCAUMwggE/
MIIBOwYLKwYBBAGBtTcBAgMwggEqMC4GCCsGAQUFBwIBFiJodHRwOi8vd3d3LnN0YXJ0c3NsLmNv
bS9wb2xpY3kucGRmMIH3BggrBgEFBQcCAjCB6jAnFiBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1
dGhvcml0eTADAgEBGoG+VGhpcyBjZXJ0aWZpY2F0ZSB3YXMgaXNzdWVkIGFjY29yZGluZyB0byB0
aGUgQ2xhc3MgMSBWYWxpZGF0aW9uIHJlcXVpcmVtZW50cyBvZiB0aGUgU3RhcnRDb20gQ0EgcG9s
aWN5LCByZWxpYW5jZSBvbmx5IGZvciB0aGUgaW50ZW5kZWQgcHVycG9zZSBpbiBjb21wbGlhbmNl
IG9mIHRoZSByZWx5aW5nIHBhcnR5IG9ibGlnYXRpb25zLjA2BgNVHR8ELzAtMCugKaAnhiVodHRw
Oi8vY3JsLnN0YXJ0c3NsLmNvbS9jcnR1MS1jcmwuY3JsMIGOBggrBgEFBQcBAQSBgTB/MDkGCCsG
AQUFBzABhi1odHRwOi8vb2NzcC5zdGFydHNzbC5jb20vc3ViL2NsYXNzMS9jbGllbnQvY2EwQgYI
KwYBBQUHMAKGNmh0dHA6Ly9haWEuc3RhcnRzc2wuY29tL2NlcnRzL3N1Yi5jbGFzczEuY2xpZW50
LmNhLmNydDAjBgNVHRIEHDAahhhodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS8wDQYJKoZIhvcNAQEF
BQADggEBAHMQmxHHodpS85X8HRyxhvfkys7r+taCNOaNU9cxQu/cZ/6k5nS2qGNMzZ6jb7ueY/V7
7p+4DW/9ZWODDTf4Fz00mh5SSVc20Bz7t+hhxwHd62PZgENh5i76Qq2tw48U8AsYo5damHby1epf
neZafLpUkLLO7AGBJIiRVTevdvyXQ0qnixOmKMWyvrhSNGuVIKVdeqLP+102Dwf+dpFyw+j1hz28
jEEKpHa+NR1b2kXuSPi/rMGhexwlJOh4tK8KQ6Ryr0rIN//NSbOgbyYZrzc/ZUWX9V5OA84ChFb2
vkFl0OcYrttp/rhDBLITwffPxSZeoBh9H7zYzkbCXKL3BUIwggYnMIIFD6ADAgECAgMN7zcwDQYJ
KoZIhvcNAQEFBQAwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYD
VQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENv
bSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQTAeFw0xNTA1MDUwOTQzNDFa
Fw0xNjA1MDUwOTUzMzZaMEIxHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcxIjAgBgkqhkiG
9w0BCQEWE2R3bXcyQGluZnJhZGVhZC5vcmcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQDJG5vZD28dY/1+EVcn/6TykmMHpXHKOvU750EGyjPJvMZFo1ySNY6SdYzGhlGRhU6CDTEmYu5W
WsFKM7nVm10istUopBDUkyR337HUQCJbKfoUfL1r47ClK8urBHajxnaGuUWO/jeFkbrFmQ2Fv0UV
hOovRC/alfOglT2KsNtlATlMOP4/x1Rglek0gfMhOYhMIZP4VLs0axWZtTCTEe5gkuwQkfC6+YxW
OtZVqQYlzVyMS2Qrw3NuikeS+bWF+N4lFTt38xEtRkVaGJ8cZNrZs33LGRubyvk63PS/DmSX5GKx
Bx9/iMONTENMP3Y1bWK9fh2JXcdEJmFwLZ4SI/lDAgMBAAGjggLZMIIC1TAJBgNVHRMEAjAAMAsG
A1UdDwQEAwIEsDAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwHQYDVR0OBBYEFLMwvegt
8Of9vnfmrUq9CKU9umCOMB8GA1UdIwQYMBaAFFNy7ZKc4NrLAVx8fpY1TvLUuFGCMB4GA1UdEQQX
MBWBE2R3bXcyQGluZnJhZGVhZC5vcmcwggFMBgNVHSAEggFDMIIBPzCCATsGCysGAQQBgbU3AQID
MIIBKjAuBggrBgEFBQcCARYiaHR0cDovL3d3dy5zdGFydHNzbC5jb20vcG9saWN5LnBkZjCB9wYI
KwYBBQUHAgIwgeowJxYgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwAwIBARqBvlRo
aXMgY2VydGlmaWNhdGUgd2FzIGlzc3VlZCBhY2NvcmRpbmcgdG8gdGhlIENsYXNzIDEgVmFsaWRh
dGlvbiByZXF1aXJlbWVudHMgb2YgdGhlIFN0YXJ0Q29tIENBIHBvbGljeSwgcmVsaWFuY2Ugb25s
eSBmb3IgdGhlIGludGVuZGVkIHB1cnBvc2UgaW4gY29tcGxpYW5jZSBvZiB0aGUgcmVseWluZyBw
YXJ0eSBvYmxpZ2F0aW9ucy4wNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5zdGFydHNzbC5j
b20vY3J0dTEtY3JsLmNybDCBjgYIKwYBBQUHAQEEgYEwfzA5BggrBgEFBQcwAYYtaHR0cDovL29j
c3Auc3RhcnRzc2wuY29tL3N1Yi9jbGFzczEvY2xpZW50L2NhMEIGCCsGAQUFBzAChjZodHRwOi8v
YWlhLnN0YXJ0c3NsLmNvbS9jZXJ0cy9zdWIuY2xhc3MxLmNsaWVudC5jYS5jcnQwIwYDVR0SBBww
GoYYaHR0cDovL3d3dy5zdGFydHNzbC5jb20vMA0GCSqGSIb3DQEBBQUAA4IBAQBzEJsRx6HaUvOV
/B0csYb35MrO6/rWgjTmjVPXMULv3Gf+pOZ0tqhjTM2eo2+7nmP1e+6fuA1v/WVjgw03+Bc9NJoe
UklXNtAc+7foYccB3etj2YBDYeYu+kKtrcOPFPALGKOXWph28tXqX53mWny6VJCyzuwBgSSIkVU3
r3b8l0NKp4sTpijFsr64UjRrlSClXXqiz/tdNg8H/naRcsPo9Yc9vIxBCqR2vjUdW9pF7kj4v6zB
oXscJSToeLSvCkOkcq9KyDf/zUmzoG8mGa83P2VFl/VeTgPOAoRW9r5BZdDnGK7baf64QwSyE8H3
z8UmXqAYfR+82M5Gwlyi9wVCMIIGNDCCBBygAwIBAgIBHjANBgkqhkiG9w0BAQUFADB9MQswCQYD
VQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwg
Q2VydGlmaWNhdGUgU2lnbmluZzEpMCcGA1UEAxMgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMDcxMDI0MjEwMTU1WhcNMTcxMDI0MjEwMTU1WjCBjDELMAkGA1UEBhMCSUwxFjAU
BgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRl
IFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUg
Q2xpZW50IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxwmDzM4t2BqxKaQuE6uW
vooyg4ymiEGWVUet1G8SD+rqvyNH4QrvnEIaFHxOhESip7vMz39ScLpNLbL1QpOlPW/tFIzNHS3q
d2XRNYG5Sv9RcGE+T4qbLtsjjJbi6sL7Ls/f/X9ftTyhxvxWkf8KW37iKrueKsxw2HqolH7GM6FX
5UfNAwAu4ZifkpmZzU1slBhyWwaQPEPPZRsWoTb7q8hmgv6Nv3Hg9rmA1/VPBIOQ6SKRkHXG0Hhm
q1dOFoAFI411+a/9nWm5rcVjGcIWZ2v/43Yksq60jExipA4l5uv9/+Hm33mbgmCszdj/Dthf13tg
Av2O83hLJ0exTqfrlwIDAQABo4IBrTCCAakwDwYDVR0TAQH/BAUwAwEB/zAOBgNVHQ8BAf8EBAMC
AQYwHQYDVR0OBBYEFFNy7ZKc4NrLAVx8fpY1TvLUuFGCMB8GA1UdIwQYMBaAFE4L7xqkQFulF2mH
MMo0aEPQQa7yMGYGCCsGAQUFBwEBBFowWDAnBggrBgEFBQcwAYYbaHR0cDovL29jc3Auc3RhcnRz
c2wuY29tL2NhMC0GCCsGAQUFBzAChiFodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9zZnNjYS5jcnQw
WwYDVR0fBFQwUjAnoCWgI4YhaHR0cDovL3d3dy5zdGFydHNzbC5jb20vc2ZzY2EuY3JsMCegJaAj
hiFodHRwOi8vY3JsLnN0YXJ0c3NsLmNvbS9zZnNjYS5jcmwwgYAGA1UdIAR5MHcwdQYLKwYBBAGB
tTcBAgEwZjAuBggrBgEFBQcCARYiaHR0cDovL3d3dy5zdGFydHNzbC5jb20vcG9saWN5LnBkZjA0
BggrBgEFBQcCARYoaHR0cDovL3d3dy5zdGFydHNzbC5jb20vaW50ZXJtZWRpYXRlLnBkZjANBgkq
hkiG9w0BAQUFAAOCAgEACoMIfXirLAZcuGOMXq4cuSN3TaFx2H2GvD5VSy/6rV55BYHbWNaPeQn3
oBSU8KgQZn/Kck1JxbLpAxVCNtsxeW1R87ifhsYZ0qjdrA9anrW2MAWCtosmAOT4OxK9QPoSjCMx
M3HbkZCDJgnlE8jMopH21BbyAYr7b5EfGRQJNtgWcvqSXwKHnTutR08+Kkn0KAkXCzeQNLeA5LlY
UzFyM7kPAp8pIRMQ+seHunmyG642S2+y/qHEdMuGIwpfz3eDF1PdctL04qYK/zu+Qg1Bw0RwgigV
Zs/0c5HP2/e9DBHh7eSwtzYlk4AUr6yxLlcwSjOfOmKEQ/Q8tzh0IFiNu9IPuTGAPBn4CPxD0+Ru
8T2wg8/s43R/PT3kd1OEqOJUl7q+h+r6fpvU0Fzxd2tC8Ga6fDEPme+1Nbi+03pVjuZQKbGwKJ66
gEn06WqaxVZC+J8hh/jR0k9mST1iAZPNYulcNJ8tKmVtjYsv0L1TSm2+NwON58tO+pIVzu3DWwSE
XSf+qkDavQam+QtEOZxLBXI++aMUEapSn+k3Lxm48ZCYfAWLb/Xj7F5JQMbZvCexglAbYR0kIHqW
5DnsYSdMD/IplJMojx0NBrxJ3fN9dvX2Y6BIXRsF1du4qESm4/3CKuyUV7p9DW3mPlHTGLvYxnyK
Qy7VFBkoLINszBrOUeIxggNvMIIDawIBATCBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcx
ODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENB
AgMN7zcwCQYFKw4DAhoFAKCCAa8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMTUxMTE2MDg0MjMzWjAjBgkqhkiG9w0BCQQxFgQU9C4N/84dtxZEB6K5IjSOS+PpMdYw
gaUGCSsGAQQBgjcQBDGBlzCBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0
ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMT
L1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMN7zcwgacG
CyqGSIb3DQEJEAILMYGXoIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRk
LjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMv
U3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAw3vNzANBgkq
hkiG9w0BAQEFAASCAQCbrLvnb7T4zcAzjKMe83iXsLldqzPuuXnMghDWJ3gGH4TsfvI2xXNH/4Gy
527Tf23eVk4NeQbkcqvTM7UFK6lj7wsNV//Qy+gNjcvrH/lwElLrAiXN0mEAH6SiVFWIShNjUq/L
wboZ6C1b95+ORdmzl9DU8QTdgksJ72LuG1Pv+q6mvA4Iyo3yXMTwh/aX2VXsdc+xEQiOUu8xnvi8
0dtauC9ztwLlmZHSFE2EbePseQhAC/2KlaKtaLJBFj6Z3CWFrD6EpDfPZsVqnuAXqzeC+w69uc51
e+xfXynyFbH8xBy1cd2yd+0gJGOeTOM1dqGVZc9iRxlhkpUSyjJvxOABAAAAAAAA


--=-yseYhWKdhoizDYIVI0ws--
