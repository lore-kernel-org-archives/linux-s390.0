Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20191209164155.GA78160@dev.jcline.org> <20191210090108.GA22512@unicorn.suse.cz>
 <20191211171822.GA36366@dev.jcline.org> <20200210194936.511ef603@laptop2-ibm.local>
In-Reply-To: <20200210194936.511ef603@laptop2-ibm.local>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 14 Feb 2020 12:31:05 +0900
Message-ID: <CAK7LNATL3Oyn=FLKm0TcB9SkJLuCOWV06a_t-FRtFiFp9Vda1g@mail.gmail.com>
Subject: Re: s390 depending on cc-options makes it difficult to configure
Content-Type: multipart/mixed; boundary="0000000000001a1415059e80d82d"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Philipp Rudo <prudo@linux.ibm.com>
Cc: Jeremy Cline <jcline@redhat.com>, Michal Kubecek <mkubecek@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>

--0000000000001a1415059e80d82d
Content-Type: text/plain; charset="UTF-8"

Hi.

On Tue, Feb 11, 2020 at 3:49 AM Philipp Rudo <prudo@linux.ibm.com> wrote:
>
> Hey Jeremy,
> Hey Michal,
>
> sorry for the late response. The mail got lost in the pre-xmas rush...
>
> In my opinion the problem goes beyond s390 and the commit you mentioned. So I'm
> also adding Masahiro as Kconfig maintainer and author of cc-option.


I did not notice the former discussion.
Thanks for CC'ing me.




> On Wed, 11 Dec 2019 12:18:22 -0500
> Jeremy Cline <jcline@redhat.com> wrote:
>
> > On Tue, Dec 10, 2019 at 10:01:08AM +0100, Michal Kubecek wrote:
> > > On Mon, Dec 09, 2019 at 11:41:55AM -0500, Jeremy Cline wrote:
> > > > Hi folks,
> > > >
> > > > Commit 5474080a3a0a ("s390/Kconfig: make use of 'depends on cc-option'")
> > > > makes it difficult to produce an s390 configuration for Fedora and Red
> > > > Hat kernels.
> > > >
> > > > The issue is I have the following configurations:
> > > >
> > > > CONFIG_MARCH_Z13=y
> > > > CONFIG_TUNE_Z14=y
> > > > # CONFIG_TUNE_DEFAULT is not set
> > > >
> > > > When the configuration is prepared on a non-s390x host without a
> > > > compiler with -march=z* it changes CONFIG_TUNE_DEFAULT to y which, as
> > > > far as I can tell, leads to a kernel tuned for z13 instead of z14.
> > > > Fedora and Red Hat build processes produce complete configurations from
> > > > snippets on any available host in the build infrastructure which very
> > > > frequently is *not* s390.
> > >
> > > We have exactly the same problem. Our developers need to update config
> > > files for different architectures and different kernel versions on their
> > > machines which are usually x86_64 but that often produces different
> > > configs than the real build environment.
> > >
> > > This is not an issue for upstream development as one usually updates
> > > configs on the same system where the build takes place but it's a big
> > > problem for distribution maintainers.
>
> If I recall correct the goal was to avoid trouble with clang, as it does not
> support all processor types with -march. But yeah, in the original
> consideration we only thought about upstream development and forgot the
> distros.
> > > > I did a quick search and couldn't find any other examples of Kconfigs
> > > > depending on march or mtune compiler flags and it seems like it'd
> > > > generally problematic for people preparing configurations.
>
> True, but not the whole story. Power and Arm64 use cc-option to check for
> -mstack-protector*, which do not exist on s390. So you have the same problem
> when you prepare a config for any of them on s390. Thus simply reverting the
> commit you mentioned above does not solve the problem but merely hides one
> symptom. Which also means that the original problem will return over and over
> again in the future.
>
> An other reason why I don't think it makes sens to revert the commit is that it
> would make cc-option as a whole useless. What's the benefit in having cc-option
> when you are not allowed to use it? Or less provocative, in which use cases is
> allowed to use cc-option?


You are right.
Reverting the particular s390 commit is not the solution.


> > > There are more issues like this. In general, since 4.17 or 4.18, the
> > > resulting config depends on both architecture and compiler version.
> > > Earlier, you could simply run "ARCH=... make oldconfig" (or menuconfig)
> > > to update configs for all architectures and distribution versions.
> > > Today, you need to use the right compiler version (results with e.g.
> > > 4.8, 7.4 and 9.2 differ) and architecture.
> > >
> >
> > Yeah, that's also troublesome. This is by no means the first problem
> > related to the environment at configuration time, but it the most
> > bothersome to work around (at least for Fedora kernel configuration).
> >
> > > At the moment, I'm working around the issue by using chroot environments
> > > with target distributions (e.g. openSUSE Tumbleweed) and set of cross
> > > compilers for supported architectures but it's far from perfect and even
> > > this way, there are problemantic points, e.g. BPFILTER_UMH which depends
> > > on gcc being able to not only compile but also link.
> > >
> > > IMHO the key problem is that .config mixes configuration with
> > > description of build environment. I have an idea of a solution which
> > > would consist of
> > >
> > >   - an option to extract "config" options which describe build
> > >     environment (i.e. their values are determined by running some
> > >     command, rather than reading from a file or asking user) into
> > >     a cache file
> > >   - an option telling "make *config" to use such cache file for these
> > >     environment "config" options instead of running the test scripts
> > >     (and probably issue an error if an environment option is missing)
> > >
> >
> > I agree that the issue is mixing kernel configuration with build
> > environment. I suppose a cache file would work, but it still sounds like
> > a difficult process that is working around that fact that folks are
> > coupling the configuration step with the build step.
>
> An other solution would be a "I know better" switch which simply disables
> cc-option for that run. That would allow the use of cc-option for upstream
> development and provide a simple way for distros to turn it off.
>
> > I would advocate that this patch be reverted and an effort made to not
> > mix build environment checks into the configuration. I'm much happier
> > for the build to fail because the configuration can't be satisfied by
> > the environment than I am for the configuration to quietly change or for
> > the tools to not allow me to make the configuration in the first place.
> > Ideally the tools would warn the user if their environment won't build
> > the configuration, but that's a nice-to-have.
>
> I too would prefer to have a warning instead of the config being silently
> changed. But again, the problem goes beyond what was reported.
>
> @Masahiro: What do you think about it?
>
> Thanks
> Philipp
>


The problem for Jeremy and Michal is,
it is difficult to get a full-feature cross-compiler
for every arch.

One idea to workaround this is
to use a fake script that accepts any flag,
and use it as $(CC) in Kconfig.

RFC patch is attached.

This is not a perfect solution, of course.


Evaluating the compiler in the Kconfig stage
conceptually has a conflict with the workflow
of distro maintainers.

I think the only way to solve it completely is,
ultimately, go back to pre 4.18 situation.
But, I am not sure if upstream people want to do it.
At least, Linus was happy to do compiler-tests
in Kconfig.

I already got several criticism about the
new feature in Kconfig because it broke the
workflow of distro maintainers. Sorry about that.


The idea from Michal, separation of the build environment
description, would work too.
IIRC, the crosstool-ng project generates some
Kconfig files based on the environment.
In hindsight, Kconfig did not need to have cc-option
but it was how I implemented. I just thought it would be cleaner to
put cc-option and the CONFIG option depending on it very close.

Anyway, comments to the attachment are appreciated.


--
Best Regards
Masahiro Yamada

--0000000000001a1415059e80d82d
Content-Type: application/x-patch; 
	name="0001-kbuild-add-dummy-toolchains-to-enable-all-cc-option-.patch"
Content-Disposition: attachment; 
	filename="0001-kbuild-add-dummy-toolchains-to-enable-all-cc-option-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k6l3kydz0>
X-Attachment-Id: f_k6l3kydz0

RnJvbSBkZjliMzc5ZDAxYjA3MDJlM2JhZjBmM2FmZWQ4OTNmN2FhMDdjMGY0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3Jn
PgpEYXRlOiBUaHUsIDEzIEZlYiAyMDIwIDIxOjE0OjAyICswOTAwClN1YmplY3Q6IFtQQVRDSCBS
RkNdIGtidWlsZDogYWRkIGR1bW15IHRvb2xjaGFpbnMgdG8gZW5hYmxlIGFsbCBjYy1vcHRpb24g
ZXRjLiBpbgogS2NvbmZpZwoKVXNhZ2U6CgogICQgbWFrZSBDUk9TU19DT01QSUxFPXNjcmlwdHMv
ZHVtbXktdG9vbHMvIG9sZGNvbmZpZwoKVGhpcyB3aWxsIG1ha2UgbW9zdCBvZiBjb21waWxlci1k
ZXBlbmRlbnQgQ09ORklHIG9wdGlvbnMgdmlzaWJsZS4KClRoaXMgaXMgUkZDLiBTZWUgY29tbWVu
dHMgaW4gc2NyaXB0cy9kdW1teS10b29scy9nY2MgZm9yIGRldGFpbHMuCgpTaWduZWQtb2ZmLWJ5
OiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3JnPgotLS0KIHNjcmlwdHMvZHVt
bXktdG9vbHMvZ2NjICAgICB8IDkxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKIHNjcmlwdHMvZHVtbXktdG9vbHMvbGQgICAgICB8ICA0ICsrCiBzY3JpcHRzL2R1bW15LXRv
b2xzL25tICAgICAgfCAgNCArKwogc2NyaXB0cy9kdW1teS10b29scy9vYmpjb3B5IHwgIDQgKysK
IDQgZmlsZXMgY2hhbmdlZCwgMTAzIGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDc1NSBz
Y3JpcHRzL2R1bW15LXRvb2xzL2djYwogY3JlYXRlIG1vZGUgMTAwNzU1IHNjcmlwdHMvZHVtbXkt
dG9vbHMvbGQKIGNyZWF0ZSBtb2RlIDEwMDc1NSBzY3JpcHRzL2R1bW15LXRvb2xzL25tCiBjcmVh
dGUgbW9kZSAxMDA3NTUgc2NyaXB0cy9kdW1teS10b29scy9vYmpjb3B5CgpkaWZmIC0tZ2l0IGEv
c2NyaXB0cy9kdW1teS10b29scy9nY2MgYi9zY3JpcHRzL2R1bW15LXRvb2xzL2djYwpuZXcgZmls
ZSBtb2RlIDEwMDc1NQppbmRleCAwMDAwMDAwMDAwMDAuLmIwZjFhOWM1NTQ5NwotLS0gL2Rldi9u
dWxsCisrKyBiL3NjcmlwdHMvZHVtbXktdG9vbHMvZ2NjCkBAIC0wLDAgKzEsOTEgQEAKKyMhL2Jp
bi9zaAorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5CisjCisjIFN0YXJp
bmcgdjQuMTgsIEtjb25maWcgZXZhbHVhdGVzIGNvbXBpbGVyIGNhcGFiaWxpdGllcywgYW5kIGhp
ZGVzIENPTkZJRworIyBvcHRpb25zIHlvdXIgY29tcGlsZXIgZG9lcyBub3Qgc3VwcG9ydC4gVGhp
cyB3b3JrcyB3ZWxsIGlmIHlvdSBjb25maWd1cmUgYW5kCisjIGJ1aWxkIHRoZSBrZXJuZWwgb24g
dGhlIHNhbWUgaG9zdCBtYWNoaW5lLgorIworIyBJdCBpcyBpbmNvbnZpbmllbnQgaWYgeW91IHBy
ZXBhcmUgdGhlIC5jb25maWcgdGhhdCBpcyBjYXJyaWVkIHRvIGEgZGlmZmVyZW50CisjIGJ1aWxk
IGVudmlyb25tZW50ICh0eXBpY2FsbHkgdGhpcyBoYXBwZW5zIHdoZW4geW91IHBhY2thZ2UgdGhl
IGtlcm5lbCBmb3IKKyMgZGlzdHJvcykgYmVjYXVzZSB1c2luZyBhIGRpZmZlcmVudCBjb21waWxl
ciBwb3RlbnRpYWxseSBwcm9kdWNlcyBkaWZmZXJlbnQKKyMgQ09ORklHIG9wdGlvbnMgdGhhbiB0
aGUgcmVhbCBidWlsZCBlbnZpcm9ubWVudC4gU28sIHlvdSBwcm9iYWJseSB3YW50IHRvIG1ha2UK
KyMgYXMgbWFueSBvcHRpb25zIHZpc2libGUgYXMgcG9zc2libGUuIEluIG90aGVyIHdvcmRzLCB5
b3UgbmVlZCB0byBjcmVhdGUgYQorIyBzdXBlci1zZXQgb2YgQ09ORklHIG9wdGlvbnMgdGhhdCBj
b3ZlciBhbnkgYnVpbGQgZW52aXJvbm1lbnQuIElmIHNvbWUgb2YgdGhlCisjIENPTkZJRyBvcHRp
b25zIHR1cm5lZCBvdXQgdG8gYmUgdW5zdXBwb3J0ZWQgb24gdGhlIGJ1aWxkIG1hY2hpbmUsIHRo
ZXkgYXJlCisjIGF1dG9tYXRpY2FsbHkgZGlzYWJsZWQgYnkgdGhlIG5hdHVyZSBvZiBLY29uZmln
LgorIworIyBIb3dldmVyLCBpdCBpcyBub3QgZmVhc2libGUgdG8gZ2V0IGEgZnVsbC1mZWF0dXJl
ZCBjb21waWxlciBmb3IgZXZlcnkgYXJjaC4KKyMgSGVuY2UgdGhlc2UgZHVtbXkgdG9vbGNoYWlu
cyB0byBtYWtlIGFsbCBjb21waWxlciB0ZXN0cyBwYXNzLgorIworIyBVc2FnZToKKyMKKyMgRnJv
bSB0aGUgdG9wIGRpcmVjdG9yeSBvZiB0aGUgc291cmNlIHRyZWUsIHJ1bgorIworIyAgICQgbWFr
ZSBDUk9TU19DT01QSUxFPXNjcmlwdHMvZHVtbXktdG9vbHMvIG9sZGNvbmZpZworIworIyBNb3N0
IG9mIGNvbXBpbGVyIGZlYXR1cmVzIGFyZSB0ZXN0ZWQgYnkgY2Mtb3B0aW9uLCB3aGljaCBzaW1w
bHkgY2hlY2tzIHRoZQorIyBleGl0IGNvZGUgb2YgJChDQykuIFRoaXMgc2NyaXB0IGRvZXMgbm90
aGluZyBhbmQganVzdCBleGl0cyB3aXRoIDAgaW4gbW9zdAorIyBjYXNlcy4gU28sICQoY2Mtb3B0
aW9uLCAuLi4pIGlzIGV2YWx1YXRlZCBhcyAneScuCisjCisjIFRoaXMgc2NyaXB0cyBjYXRlcnMg
dG8gbW9yZSBjaGVja3M7IGhhbmRsZSAtLXZlcnNpb24gYW5kIHByZS1wcm9jZXNzIF9fR05VQ19f
CisjIGV0Yy4gdG8gcHJldGVuZCB0byBiZSBHQ0MsIGFuZCBhbHNvIGRvIHJpZ2h0IHRoaW5ncyB0
byBzYXRpc2Z5IHNvbWUgc2NyaXB0cy4KKworIyBDaGVjayBpZiB0aGUgZmlyc3QgcGFyYW1ldGVy
IGFwcGVhcnMgaW4gdGhlIHJlc3QuIFN1Y2NlZWRzIGlmIGZvdW5kLgorIyBUaGlzIGhlbHBlciBp
cyB1c2VmdWwgaWYgYSBwYXJ0aWN1bGFyIG9wdGlvbiB3YXMgcGFzc2VkIHRvIHRoaXMgc2NyaXB0
LgorIyBUeXBpY2FsbHkgdXNlZCBsaWtlIHRoaXM6CisjICAgYXJnX2NvbnRhaW4gPHdvcmQteW91
LWFyZS1zZWFyY2hpbmctZm9yPiAiJEAiCithcmdfY29udGFpbiAoKQoreworCXNlYXJjaD0iJDEi
CisJc2hpZnQKKworCXdoaWxlIFsgJCMgLWd0IDAgXQorCWRvCisJCWlmIFsgIiRzZWFyY2giID0g
IiQxIiBdOyB0aGVuCisJCQlyZXR1cm4gMAorCQlmaQorCQlzaGlmdAorCWRvbmUKKworCXJldHVy
biAxCit9CisKKyMgVG8gc2V0IENPTkZJR19DQ19JU19HQ0M9eQoraWYgYXJnX2NvbnRhaW4gLS12
ZXJzaW9uICIkQCI7IHRoZW4KKwllY2hvICJnY2MgKHNjcmlwdHMvZHVtbXktdG9vbHMvZ2NjKSIK
KwlleGl0IDAKK2ZpCisKK2lmIGFyZ19jb250YWluIC1FICIkQCI7IHRoZW4KKwkjIEZvciBzY3Jp
cHRzL2djYy12ZXJzaW9uLnNoOyBUaGlzIGVtdWxhdGVzIEdDQyAyMC4wLjAKKwlpZiBhcmdfY29u
dGFpbiAtICIkQCI7IHRoZW4KKwkJc2VkICdzL15fX0dOVUNfXyQvMjAvOyBzL15fX0dOVUNfTUlO
T1JfXyQvMC87IHMvXl9fR05VQ19QQVRDSExFVkVMX18kLzAvJworCQlleGl0IDAKKwllbHNlCisJ
CWVjaG8gIm5vIGlucHV0IGZpbGVzIiA+JjIKKwkJZXhpdCAxCisJZmkKK2ZpCisKK2lmIGFyZ19j
b250YWluIC1TICIkQCI7IHRoZW4KKwkjIEZvciBzY3JpcHRzL2djYy14ODYtKi1oYXMtc3RhY2st
cHJvdGVjdG9yLnNoCisJaWYgYXJnX2NvbnRhaW4gLWZzdGFjay1wcm90ZWN0b3IgIiRAIjsgdGhl
bgorCQllY2hvICIlZ3MiCisJCWV4aXQgMAorCWZpCitmaQorCisjIEZvciBzY3JpcHRzL2djYy1w
bHVnaW4uc2gKK2lmIGFyZ19jb250YWluIC1wcmludC1maWxlLW5hbWU9cGx1Z2luICIkQCI7IHRo
ZW4KKwlwbHVnaW5fZGlyPSQobWt0ZW1wIC1kKQorCisJc2VkIC1uICdzLy4qI2luY2x1ZGUgIlwo
LipcKSIvXDEvcCcgJChkaXJuYW1lICQwKS8uLi9nY2MtcGx1Z2lucy9nY2MtY29tbW9uLmggfAor
CXdoaWxlIHJlYWQgaGVhZGVyCisJZG8KKwkJbWtkaXIgLXAgJHBsdWdpbl9kaXIvaW5jbHVkZS8k
KGRpcm5hbWUgJGhlYWRlcikKKwkJdG91Y2ggJHBsdWdpbl9kaXIvaW5jbHVkZS8kaGVhZGVyCisJ
ZG9uZQorCisJZWNobyAkcGx1Z2luX2RpcgorCWV4aXQgMAorZmkKZGlmZiAtLWdpdCBhL3Njcmlw
dHMvZHVtbXktdG9vbHMvbGQgYi9zY3JpcHRzL2R1bW15LXRvb2xzL2xkCm5ldyBmaWxlIG1vZGUg
MTAwNzU1CmluZGV4IDAwMDAwMDAwMDAwMC4uM2JjNTZhZTRjYzE1Ci0tLSAvZGV2L251bGwKKysr
IGIvc2NyaXB0cy9kdW1teS10b29scy9sZApAQCAtMCwwICsxLDQgQEAKKyMhL2Jpbi9zaAorIyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5CisKKyMgRHVtbXkgc2NyaXB0IHRo
YXQgYWx3YXlzIHN1Y2NlZWRzCmRpZmYgLS1naXQgYS9zY3JpcHRzL2R1bW15LXRvb2xzL25tIGIv
c2NyaXB0cy9kdW1teS10b29scy9ubQpuZXcgZmlsZSBtb2RlIDEwMDc1NQppbmRleCAwMDAwMDAw
MDAwMDAuLjNiYzU2YWU0Y2MxNQotLS0gL2Rldi9udWxsCisrKyBiL3NjcmlwdHMvZHVtbXktdG9v
bHMvbm0KQEAgLTAsMCArMSw0IEBACisjIS9iaW4vc2gKKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjAtb25seQorCisjIER1bW15IHNjcmlwdCB0aGF0IGFsd2F5cyBzdWNjZWVkcwpk
aWZmIC0tZ2l0IGEvc2NyaXB0cy9kdW1teS10b29scy9vYmpjb3B5IGIvc2NyaXB0cy9kdW1teS10
b29scy9vYmpjb3B5Cm5ldyBmaWxlIG1vZGUgMTAwNzU1CmluZGV4IDAwMDAwMDAwMDAwMC4uM2Jj
NTZhZTRjYzE1Ci0tLSAvZGV2L251bGwKKysrIGIvc2NyaXB0cy9kdW1teS10b29scy9vYmpjb3B5
CkBAIC0wLDAgKzEsNCBAQAorIyEvYmluL3NoCisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wLW9ubHkKKworIyBEdW1teSBzY3JpcHQgdGhhdCBhbHdheXMgc3VjY2VlZHMKLS0gCjIu
MTcuMQoK
--0000000000001a1415059e80d82d--
