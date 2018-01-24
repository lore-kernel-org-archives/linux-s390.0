From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Avoiding information leaks between users and between processes
 by default? [Was: : [PATCH 1/5] prctl: add PR_ISOLATE_BP process control]
Date: Wed, 24 Jan 2018 09:24:06 +0000
Message-ID: <1516785846.13558.106.camel@infradead.org>
References: <1516712825-2917-1-git-send-email-schwidefsky@de.ibm.com>
         <1516712825-2917-2-git-send-email-schwidefsky@de.ibm.com>
         <20180123170719.GA4154@isilmar-4.linta.de>
         <20180124072953.50851fec@mschwideX1>
         <20180124083705.GA14868@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/x-pkcs7-signature"; boundary="=-puagsNtTFvLtmCYPcuUv"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180124083705.GA14868@light.dominikbrodowski.net>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>, w@1wt.eu, keescook@chromium.org, thomas.lendacky@amd.com, ak@linux.intel.com, pavel@ucw.cz
List-ID: <linux-s390.vger.kernel.org>


--=-puagsNtTFvLtmCYPcuUv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-01-24 at 09:37 +0100, Dominik Brodowski wrote:
> On Wed, Jan 24, 2018 at 07:29:53AM +0100, Martin Schwidefsky wrote:
> >=20
> > On Tue, 23 Jan 2018 18:07:19 +0100
> > Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> >=20
> > >=20
> > > On Tue, Jan 23, 2018 at 02:07:01PM +0100, Martin Schwidefsky wrote:
> > > >=20
> > > > Add the PR_ISOLATE_BP operation to prctl. The effect of the process
> > > > control is to make all branch prediction entries created by the exe=
cution
> > > > of the user space code of this task not applicable to kernel code o=
r the
> > > > code of any other task.=C2=A0=C2=A0
> > >
> > > What is the rationale for requiring a per-process *opt-in* for this a=
dded
> > > protection?
> > >=20
> > > For KPTI on x86, the exact opposite approach is being discussed (see,=
 e.g.
> > > http://lkml.kernel.org/r/1515612500-14505-1-git-send-email-w@1wt.eu )=
: By
> > > default, play it safe, with KPTI enabled. But for "trusted" processes=
, one
> > > may opt out using prctrl.
> >
> > The rationale is that there are cases where you got code from *somewher=
e*
> > and want to run it in an isolated context. Think: a docker container th=
at
> > runs under KVM. But with spectre this is still not really safe. So you
> > include a wrapper program in the docker container to use the trap door
> > prctl to start the potential malicious program. Now you should be good,=
 no?
>
> Well, partly. It may be that s390 and its use cases are special -- but as=
 I
> understand it, this uapi question goes beyond this question:
>=20
> To my understanding, Linux traditionally tried to aim for the security go=
al
> of avoiding information leaks *between* users[+], probably even between
> processes of the same user. It wasn't a guarantee, and there always were
> (and will be) information leaks -- and that is where additional safeguard=
s
> such as seccomp come into play, which reduce the attack surface against
> unknown or unresolved security-related bugs. And everyone knew (or should
> have known) that allowing "untrusted" code to be run (be it by an user, b=
e
> it JavaScript, etc.) is more risky. But still, avoiding information leaks
> between users and between processes was (to my understanding) at least a
> goal.[=C2=A7]
>=20
> In recent days however, the outlook on this issue seems to have shifted:
>=20
> - Your proposal would mean to trust all userspace code, unless it is
> =C2=A0 specifically marked as untrusted. As I understand it, this would m=
ean that
> =C2=A0 by default, spectre isn't fully mitigated cross-user and cross-pro=
cess,
> =C2=A0 though the kernel could. And rogue user-run code may make use of t=
hat,
> =C2=A0 unless it is run with a special wrapper.
>=20
> - Concerning x86 and IPBP, the current proposal is to limit the protectio=
n
> =C2=A0 offered by IPBP to non-dumpable processes. As I understand it, thi=
s would
> =C2=A0 mean that other processes are left hanging out to dry.[~]
>=20
> - Concerning x86 and STIBP, David mentioned that "[t]here's an argument t=
hat
> =C2=A0 there are so many other information leaks between HT siblings that=
 we
> =C2=A0 might not care"; in the last couple of hours, a proposal emerged t=
o limit
> =C2=A0 the protection offered by STIBP to non-dumpable processes as well.=
 To my
> =C2=A0 understanding, this would mean that many processes are left hangin=
g out to
> =C2=A0 dry again.
>=20
> I am a bit worried whether this is a sign for a shift in the security goa=
ls.
> I fully understand that there might be processes (e.g. some[?] kernel
> threads) and users (root) which you need to trust anyway, as they can
> already access anything. Disabling additional, costly safeguards for
> those special cases then seems OK. Opting out of additional protections f=
or
> single-user or single-use systems (haproxy?) might make sense as well. Bu=
t
> the kernel[*] not offering full[#] spectre mitigation by default for regu=
lar
> users and their processes? I'm not so sure.

Note that for STIBP/IBPB the operation of the flag is different in
another way. We're using it as a "protect this process from others"
flag, not a "protect others from this process" flag.

I'm not sure this is a fundamental shift in overall security goals;
more a recognition that on *current* hardware the cost of 100%
protection against an attack that was fairly unlikely in the first
place, is fairly prohibitive. For a process to make itself non-dumpable=20
is a simple enough way to opt in. And *maybe* we could contemplate a
command line option for 'IBPB always' but I'm *really* wary of exposing
too much of that stuff, rather than simply trying to Do The Right
Thing.

> [*] Whether CPUs should enable full mitigation (IBRS_ALL) by default
> =C2=A0 =C2=A0 in future has been discussed on this list as well.

The kernel will do that; it's just not implemented yet because it's
slightly non-trivial and can't be fully tested yet. We *will* want to
ALTERNATIVE away the retpolines and just set IBRS_ALL because it'll be
faster to do so.

For IBRS_ALL, note that we still need the same IBPB flushes on context
switch; just not STIBP. That's because IBRS_ALL, as Linus so eloquently
reminded us, is *still* a stop-gap measure and not actually a fix.
Reading between the lines, I think tagging predictions with the ring
(and HT sibling?) they came from is the best they could slip into the
next generation without having to stop the fabs for two years while
they go back to the drawing board.

A real fix will *hopefully* come later, but unfortunately Intel haven't
even defined the bit in IA32_ARCH_CAPABILITIES which advertises "you
don't have to do any of this shit any more; we fixed it", analogous to
their RDCL_NO bit for "no more Meltdown". I'm *hoping* that's just an
oversight in preparing the doc and not looking far enough ahead, rather
than an actual *intent* to never fix it properly as Linus inferred.


--=-puagsNtTFvLtmCYPcuUv
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEFQw
ggUxMIIEGaADAgECAhBNRhEyk/HZ7naOeTHWrzuAMA0GCSqGSIb3DQEBCwUAMIGXMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYD
VQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0xNzEyMjEwMDAwMDBaFw0xODEyMjEyMzU5
NTlaMCQxIjAgBgkqhkiG9w0BCQEWE2R3bXcyQGluZnJhZGVhZC5vcmcwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQDgzLNWa18DNpGUj/ZeH0Sgz53ESIbzdPw3OJeuNP6jZhxZojbyfxbM
hETscxI/Hj6UZ4a7sHm5BkVjlsB1Af2Za/PXUt8MmLAcPMHkMPGunvkUibEvblDvpqMkQZlaZM+t
5PqFmWkbehLaEvbpNY7dmEAAeKh4klTzJzrr5AAzaCQ32cA2e3+DEIv5O5l9ViMIjy/JM+xMQrfX
3PZ0chY1PaVWjg59d4Uno+5LRDbgCnPkKJX4ysBGadibjBGQGJEZCjh94iiEebn2KsRLvtrJ72Ph
3W2HDEdngW3YP0wujFQVs81U7L8XN3kdPRsa9zNqGtYQP/+1KMMJQ57hnfi9AgMBAAGjggHpMIIB
5TAfBgNVHSMEGDAWgBSCr2yM+MX+lmF86B89K3FIXsSLwDAdBgNVHQ4EFgQUpL+/5lli9jmj2KHj
ryyhnB2xRt0wDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwIAYDVR0lBBkwFwYIKwYBBQUH
AwQGCysGAQQBsjEBAwUCMBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNVHSAEPzA9MDsGDCsGAQQBsjEB
AgEBATArMCkGCCsGAQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8E
UzBRME+gTaBLhklodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50
aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKG
SWh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5k
U2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAe
BgNVHREEFzAVgRNkd213MkBpbmZyYWRlYWQub3JnMA0GCSqGSIb3DQEBCwUAA4IBAQCK28BdbVJ9
QKQqTDfXwogAYiRBEGptfE1Bjy4F5vC6eWJqOJ15vunxjLwdbZYb4L0qrJlh+ZHHHlbIK8uEZu7N
XHUntmWMbGbZiu7JgrbSXJK1ct9gxrN/sdWYJ+JDjVHg7GfDTvTTPa26JMRqJsO1TjjyDX7A3K39
TjV8C0hqXvwF9BsNf+qBeWO6GVzJ5572awY221hc1umibmZaKV4fg+7fS7qscx5TSuIc6uvMBQhm
7NQiCq6euMMWBDUDlotQCDW0ilm0OuLW3IVLuZCm6Msc+6hT9+dCT4JUvxTHZnnO7uLCxV+Ujad+
PH3itRm38i96p2zvwgLr8vwWA0ckMIIFMTCCBBmgAwIBAgIQTUYRMpPx2e52jnkx1q87gDANBgkq
hkiG9w0BAQsFADCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQ
MA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENP
TU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTcx
MjIxMDAwMDAwWhcNMTgxMjIxMjM1OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZyYWRl
YWQub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4MyzVmtfAzaRlI/2Xh9EoM+d
xEiG83T8NziXrjT+o2YcWaI28n8WzIRE7HMSPx4+lGeGu7B5uQZFY5bAdQH9mWvz11LfDJiwHDzB
5DDxrp75FImxL25Q76ajJEGZWmTPreT6hZlpG3oS2hL26TWO3ZhAAHioeJJU8yc66+QAM2gkN9nA
Nnt/gxCL+TuZfVYjCI8vyTPsTEK319z2dHIWNT2lVo4OfXeFJ6PuS0Q24Apz5CiV+MrARmnYm4wR
kBiRGQo4feIohHm59irES77aye9j4d1thwxHZ4Ft2D9MLoxUFbPNVOy/Fzd5HT0bGvczahrWED//
tSjDCUOe4Z34vQIDAQABo4IB6TCCAeUwHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8Aw
HQYDVR0OBBYEFKS/v+ZZYvY5o9ih468soZwdsUbdMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8E
AjAAMCAGA1UdJQQZMBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAw
RgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUu
Y29tb2RvLm5ldC9DUFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5jb21vZG9jYS5jb20v
Q09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBiwYIKwYB
BQUHAQEEfzB9MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FD
bGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3J0MCQGCCsGAQUFBzABhhhodHRw
Oi8vb2NzcC5jb21vZG9jYS5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkq
hkiG9w0BAQsFAAOCAQEAitvAXW1SfUCkKkw318KIAGIkQRBqbXxNQY8uBebwunliajideb7p8Yy8
HW2WG+C9KqyZYfmRxx5WyCvLhGbuzVx1J7ZljGxm2YruyYK20lyStXLfYMazf7HVmCfiQ41R4Oxn
w0700z2tuiTEaibDtU448g1+wNyt/U41fAtIal78BfQbDX/qgXljuhlcyeee9msGNttYXNbpom5m
WileH4Pu30u6rHMeU0riHOrrzAUIZuzUIgqunrjDFgQ1A5aLUAg1tIpZtDri1tyFS7mQpujLHPuo
U/fnQk+CVL8Ux2Z5zu7iwsVflI2nfjx94rUZt/Iveqds78IC6/L8FgNHJDCCBeYwggPOoAMCAQIC
EGqb4Tg7/ytrnwHV2binUlYwDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNVBAYTAkdCMRswGQYDVQQI
ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBD
QSBMaW1pdGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4X
DTEzMDExMDAwMDAwMFoXDTI4MDEwOTIzNTk1OVowgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBM
aW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2Vj
dXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvrOeV6wodnVAFsc4
A5jTxhh2IVDzJXkLTLWg0X06WD6cpzEup/Y0dtmEatrQPTRI5Or1u6zf+bGBSyD9aH95dDSmeny1
nxdlYCeXIoymMv6pQHJGNcIDpFDIMypVpVSRsivlJTRENf+RKwrB6vcfWlP8dSsE3Rfywq09N0Zf
xcBa39V0wsGtkGWC+eQKiz4pBZYKjrc5NOpG9qrxpZxyb4o4yNNwTqzaaPpGRqXB7IMjtf7tTmU2
jqPMLxFNe1VXj9XB1rHvbRikw8lBoNoSWY66nJN/VCJv5ym6Q0mdCbDKCMPybTjoNCQuelc0IAaO
4nLUXk0BOSxSxt8kCvsUtQIDAQABo4IBPDCCATgwHwYDVR0jBBgwFoAUu69+Aj36pvE8hI6t7jiY
7NkyMtQwHQYDVR0OBBYEFIKvbIz4xf6WYXzoHz0rcUhexIvAMA4GA1UdDwEB/wQEAwIBhjASBgNV
HRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0gADBMBgNVHR8ERTBDMEGgP6A9hjtodHRw
Oi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDBx
BggrBgEFBQcBAQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9E
T1JTQUFkZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20w
DQYJKoZIhvcNAQEMBQADggIBAHhcsoEoNE887l9Wzp+XVuyPomsX9vP2SQgG1NgvNc3fQP7TcePo
7EIMERoh42awGGsma65u/ITse2hKZHzT0CBxhuhb6txM1n/y78e/4ZOs0j8CGpfb+SJA3GaBQ+39
4k+z3ZByWPQedXLL1OdK8aRINTsjk/H5Ns77zwbjOKkDamxlpZ4TKSDMKVmU/PUWNMKSTvtlenlx
Bhh7ETrN543j/Q6qqgCWgWuMAXijnRglp9fyadqGOncjZjaaSOGTTFB+E2pvOUtY+hPebuPtTbq7
vODqzCM6ryEhNhzf+enm0zlpXK7q332nXttNtjv7VFNYG+I31gnMrwfHM5tdhYF/8v5UY5g2xANP
ECTQdu9vWPoqNSGDt87b3gXb1AiGGaI06vzgkejL580ul+9hz9D0S0U4jkhJiA7EuTecP/CFtR72
uYRBcunwwH3fciPjviDDAI9SnC/2aPY8ydehzuZutLbZdRJ5PDEJM/1tyZR2niOYihZ+FCbtf3D9
mB12D4ln9icgc7CwaxpNSCPt8i/GqK2HsOgkL3VYnwtx7cJUmpvVdZ4ognzgXtgtdk3ShrtOS1iA
N2ZBXFiRmjVzmehoMof06r1xub+85hFQzVxZx5/bRaTKTlL8YXLI8nAbR9HWdFqzcOoB/hxfEyIQ
px9/s81rgzdEZOofSlZHynoSMYIDxzCCA8MCAQEwgawwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQI
ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBD
QSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQg
U2VjdXJlIEVtYWlsIENBAhBNRhEyk/HZ7naOeTHWrzuAMA0GCWCGSAFlAwQCAQUAoIIB6zAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xODAxMjQwOTI0MDZaMC8GCSqG
SIb3DQEJBDEiBCBtomkIF4JY8i8wFi6bSy6ThZmaJER5AYOMWGPAjP2blzCBvQYJKwYBBAGCNxAE
MYGvMIGsMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RP
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQTUYRMpPx2e52
jnkx1q87gDCBvwYLKoZIhvcNAQkQAgsxga+ggawwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBM
aW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2Vj
dXJlIEVtYWlsIENBAhBNRhEyk/HZ7naOeTHWrzuAMA0GCSqGSIb3DQEBAQUABIIBACJcZkhPJCkT
IBjBf8omv0AoqCOdD6q8Q9f/s5qiNyz9O6tUYck/izNvL9wpik/XtN/1Rk+pHjrD0SkHwMeCvydQ
YsQ8i9jriBlkWkFMwYOWc9Q9QQF6my7v2dyu3ue6d/BojpsjgeaQJ373DGv5vquy3X+swXjP7aow
dma5mYek1IOtKqWiJ/pINBb2W9O9e1fLYd5a7IqSMji9VqyXtasE82eqUgwW6Orelm6X/KWkPym5
Uc2DtdLKu+9/zKtfyZ/Bu2bN2MCFwrZb11DfYVROx5Kv9lAU0MRnRgBZE9FDlRmebNZzulyeY92+
prSO1SyMOdF4AHnyBjvWKKAzyCkAAAAAAAA=


--=-puagsNtTFvLtmCYPcuUv--
