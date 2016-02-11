From: Robert Richter <robert.richter@caviumnetworks.com>
Subject: Re: [PATCH v10 3/8] dt, numa: adding numa dt binding implementation.
Date: Thu, 11 Feb 2016 16:32:55 +0100
Message-ID: <20160211153255.GR24726@rric.localdomain>
References: <1454407763-1017-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1454407763-1017-4-git-send-email-gkulkarni@caviumnetworks.com>
 <CAL_JsqK5HV9yzBE+ANnTw26eVR7Dy+B8OkwQ-7WF8KDa86Fd9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqK5HV9yzBE+ANnTw26eVR7Dy+B8OkwQ-7WF8KDa86Fd9g@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-ia64@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Pawel Moll <pawel.moll@arm.com>, Al Stone <al.stone@linaro.org>, Prasun.Kapoor@caviumnetworks.com, "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Mark Salter <msalter@redhat.com>, rfranz@cavium.com, Len Brown <lenb@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>, Steve Capper <steve.capper@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>Marc Zyngier <m>
List-ID: <linux-s390.vger.kernel.org>

On 11.02.16 08:50:41, Rob Herring wrote:
> On Tue, Feb 2, 2016 at 4:09 AM, Ganapatrao Kulkarni
> <gkulkarni@caviumnetworks.com> wrote:
> > dt node parsing for numa topology is done using device property
> > numa-node-id and device node distance-map.
> 
> How is it that powerpc doesn't need flat DT parsing for NUMA? Both
> arches are memblock based and the binding is similar IIRC, so you
> should be able to find a way to do this with the unflattened tree.
> Ideally, there should be some common code shared as well.
> 
> Do you have a git tree with this series?

I have pushed it here for you:

 https://git.kernel.org/cgit/linux/kernel/git/rric/linux.git/log/?h=thunder/numa-v10

-Robert
