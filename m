Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160120141806.GA8434@rob-hp-laptop>
References: <1453134965-6125-1-git-send-email-gkulkarni@caviumnetworks.com>
	<1453134965-6125-3-git-send-email-gkulkarni@caviumnetworks.com>
	<20160120141806.GA8434@rob-hp-laptop>
Date: Tue, 26 Jan 2016 22:46:10 +0530
Message-ID: <CAFpQJXXtrZk19XBM=BTGZMgtNy-xppoG7NZ_nDAv=Nt5P62e6g@mail.gmail.com>
Subject: Re: [PATCH v9 2/6] Documentation, dt, arm64/arm: dt bindings for numa.
From: Ganapatrao Kulkarni <gpkulkarni@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160126171610.n3EK4Iotk17O1eil8NpKG8GsdpB9fGvK9czyjicJYcI@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Grant Likely <grant.likely@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, rfranz@cavium.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "msalter@redhat.com" <msalter@redhat.com>, Steve Capper <steve.capper@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <al.stone@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, tony.luck@intel.com, fenghua.yu@intel.com, james.hogan@imgtec.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "tglx@linutronix.de" <tglx@linutronix.de>, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, Jon Masters <jonathan@jonmasters.org>, Robert Richter <rrichter@cavium.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Rob, Mark,


On Wed, Jan 20, 2016 at 7:48 PM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Jan 18, 2016 at 10:06:01PM +0530, Ganapatrao Kulkarni wrote:
>> DT bindings for numa mapping of memory, cores and IOs.
>>
>> Reviewed-by: Robert Richter <rrichter@cavium.com>
>> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>> ---
>>  Documentation/devicetree/bindings/arm/numa.txt | 272 +++++++++++++++++++++++++
>>  1 file changed, 272 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/numa.txt
>
> This is looks okay to me, but some cosmetic things on the example.
can i have your Ack please?
>
>> +==============================================================================
>> +4 - Example dts
>> +==============================================================================
>> +
>> +2 sockets system consists of 2 boards connected through ccn bus and
>> +each board having one socket/soc of 8 cpus, memory and pci bus.
>> +
>> +     memory@00c00000 {
>
> Drop the leading 0s on unit addresses.
i will correct these in next version.
>
>> +             device_type = "memory";
>> +             reg = <0x0 0x00c00000 0x0 0x80000000>;
>> +             /* node 0 */
>> +             numa-node-id = <0>;
>> +     };
>> +
>> +     memory@10000000000 {
>> +             device_type = "memory";
>> +             reg = <0x100 0x00000000 0x0 0x80000000>;
>> +             /* node 1 */
>> +             numa-node-id = <1>;
>> +     };
>> +
>> +     cpus {
>> +             #address-cells = <2>;
>> +             #size-cells = <0>;
>> +
>> +             cpu@000 {
>
> Same here (leaving one of course).
>
>> +                     device_type = "cpu";
>> +                     compatible =  "arm,armv8";
>> +                     reg = <0x0 0x000>;
>> +                     enable-method = "psci";
>> +                     /* node 0 */
>> +                     numa-node-id = <0>;
>> +             };
>> +             cpu@001 {
>
> and so on...
>
>> +                     device_type = "cpu";
>> +                     compatible =  "arm,armv8";
>> +                     reg = <0x0 0x001>;
>
> Either all leading 0s or none.
>
>> +                     reg = <0x0 0x008>;
>> +                     enable-method = "psci";
>> +                     /* node 1 */
>
> Kind of a pointless comment.
>
> Wouldn't each cluster of cpus for a given numa node be in a different
> cpu affinity? Certainly not required by the architecture, but the common
> case at least.
>
>> +                     numa-node-id = <1>;
>> +             };
>
> [...]
>
>> +     pcie0: pcie0@0x8480,00000000 {
>
> Drop the 0x and the comma.
>
>> +             compatible = "arm,armv8";
>> +             device_type = "pci";
>> +             bus-range = <0 255>;
>> +             #size-cells = <2>;
>> +             #address-cells = <3>;
>> +             reg = <0x8480 0x00000000 0 0x10000000>;  /* Configuration space */
>> +             ranges = <0x03000000 0x8010 0x00000000 0x8010 0x00000000 0x70 0x00000000>;
>> +             /* node 0 */
>> +             numa-node-id = <0>;
>> +        };
>> +
>> +     pcie1: pcie1@0x9480,00000000 {
>
> ditto
>
>> +             compatible = "arm,armv8";
>> +             device_type = "pci";
>> +             bus-range = <0 255>;
>> +             #size-cells = <2>;
>> +             #address-cells = <3>;
>> +             reg = <0x9480 0x00000000 0 0x10000000>;  /* Configuration space */
>> +             ranges = <0x03000000 0x9010 0x00000000 0x9010 0x00000000 0x70 0x00000000>;
>> +             /* node 1 */
>> +             numa-node-id = <1>;
>> +        };
>> +
>> +     distance-map {
>> +             compatible = "numa-distance-map-v1";
>> +             distance-matrix = <0 0 10>,
>> +                               <0 1 20>,
>> +                               <1 1 10>;
>> +     };
>> --
>> 1.8.1.4
thanks
Ganapat
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
